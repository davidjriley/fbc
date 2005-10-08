''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
''
''	This program is free software; you can redistribute it and/or modify
''	it under the terms of the GNU General Public License as published by
''	the Free Software Foundation; either version 2 of the License, or
''	(at your option) any later version.
''
''	This program is distributed in the hope that it will be useful,
''	but WITHOUT ANY WARRANTY; without even the implied warranty of
''	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
''	GNU General Public License for more details.
''
''	You should have received a copy of the GNU General Public License
''	along with this program; if not, write to the Free Software
''	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA.


'' quirk file statements and functions (PRINT, WRITE, OPEN, ...) parsing
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\rtl.bi"
#include once "inc\ast.bi"

'':::::
'' PrintStmt	  =   (PRINT|'?') ('#' Expression ',')? (USING Expression{str} ';')? (Expression? ';'|"," )*
''
function cPrintStmt as integer
    dim as ASTNODE ptr usingexpr, filexpr, filexprcopy, expr
    dim as integer expressions, issemicolon, iscomma, istab, isspc, islprint

	function = FALSE

	'' (PRINT|'?')
	if( not hMatch( FB_TK_PRINT ) ) then
		if( not hMatch( CHAR_QUESTION ) ) then
            if( not hMatch( FB_TK_LPRINT ) ) then
				exit function
            else
                islprint = TRUE
            end if
		end if
	end if

    if( islprint ) then
    	filexpr = astNewCONSTi( -1, IR_DATATYPE_INTEGER )
    else
        '' ('#' Expression)?
        if( hMatch( CHAR_SHARP ) ) then
            hMatchExpression( filexpr )

            hMatchCOMMA( )

        else
            filexpr = astNewCONSTi( 0, IR_DATATYPE_INTEGER )
        end if
    end if

	'' (USING Expression{str} ';')?
	usingexpr = NULL
	if( hMatch( FB_TK_USING ) ) then
		hMatchExpression( usingexpr )

		if( not hMatch( CHAR_SEMICOLON ) ) then
			hReportError FB_ERRMSG_EXPECTEDSEMICOLON
			exit function
		end if

		if( not rtlPrintUsingInit( usingexpr, islprint ) ) then
			exit function
		end if
    end if

    '' (Expression?|SPC(Expression)|TAB(Expression) ';'|"," )*
    expressions = 0
    do
        '' (Expression?|SPC(Expression)|TAB(Expression)
        isspc = FALSE
        istab = FALSE
        if( hMatch( FB_TK_SPC ) ) then
        	isspc = TRUE
			hMatchLPRNT( )

			hMatchExpression( expr )

			hMatchRPRNT( )

        elseif( hMatch( FB_TK_TAB ) ) then
            istab = TRUE
			hMatchLPRNT( )

			hMatchExpression( expr )

			hMatchRPRNT( )

        elseif( not cExpression( expr ) ) then
        	expr = NULL
        end if

		iscomma = FALSE
		issemicolon = FALSE
		if( hMatch( CHAR_COMMA ) ) then
			iscomma = TRUE
		elseif( hMatch( CHAR_SEMICOLON ) ) then
			issemicolon = TRUE
		end if

    	filexprcopy = astCloneTree( filexpr )

    	'' handle PRINT w/o expressions
    	if( (not iscomma) and (not issemicolon) and (expr = NULL) ) then
    		if( usingexpr = NULL ) then
    			if( expressions = 0 ) then
    				if( not rtlPrint( filexprcopy, FALSE, FALSE, NULL, islprint ) ) then
						exit function
					end if
    			end if
    		else
    			if( not rtlPrintUsingEnd( filexprcopy, islprint ) ) then
					exit function
				end if
    		end if

    		exit do
    	end if

    	if( usingexpr = NULL ) then
    		if( isspc ) then
    			if( not rtlPrintSPC( filexprcopy, expr, islprint ) ) then
					exit function
				end if
    		elseif( istab ) then
    			if( not rtlPrintTab( filexprcopy, expr, islprint ) ) then
					exit function
				end if
    		else
    			if( not rtlPrint( filexprcopy, iscomma, issemicolon, expr, islprint ) ) then
					hReportError FB_ERRMSG_INVALIDDATATYPES
					exit function
				end if
    		end if

    	else
    		if( not rtlPrintUsing( filexprcopy, expr, iscomma, issemicolon, islprint ) ) then
    			hReportError FB_ERRMSG_INVALIDDATATYPES
				exit function
			end if
    	end if

    	expressions += 1
    loop while( iscomma or issemicolon )

    ''
    astDelTree( filexpr )

    function = TRUE

end function

'':::::
'' WriteStmt	  =   WRITE ('#' Expression)? (Expression? "," )*
''
function cWriteStmt as integer
    dim as ASTNODE ptr filexpr, filexprcopy, expr
    dim as integer expressions, iscomma

	function = FALSE

	'' WRITE
	if( not hMatch( FB_TK_WRITE ) ) then
		exit function
	end if

	'' ('#' Expression)?
	if( hMatch( CHAR_SHARP ) ) then
		hMatchExpression( filexpr )

		hMatchCOMMA( )

    else
    	filexpr = astNewCONSTi( 0, IR_DATATYPE_INTEGER )
	end if

    '' (Expression? "," )*
    expressions = 0
    do
		if( not cExpression( expr ) ) then
        	expr = NULL
        end if

		iscomma = FALSE
		if( hMatch( CHAR_COMMA ) ) then
			iscomma = TRUE
		end if

    	filexprcopy = astCloneTree( filexpr )

    	'' handle WRITE w/o expressions
    	if( (not iscomma) and (expr = NULL) ) then
    		if( expressions = 0 ) then
    			rtlWrite( filexprcopy, FALSE, NULL )
    		end if

    		exit do
    	end if

    	if( not rtlWrite( filexprcopy, iscomma, expr ) ) then
    		hReportError FB_ERRMSG_INVALIDDATATYPES
    		exit function
    	end if

    	expressions += 1
    loop while( iscomma )

    ''
    astDelTree( filexpr )

    function = TRUE

end function

'':::::
'' LineInputStmt	  =   LINE INPUT ';'? ('#' Expression| Expression{str}?) (','|';')? Variable? .
''
function cLineInputStmt as integer
    dim as ASTNODE ptr expr, dstexpr
    dim as integer isfile, addnewline, issep, addquestion

	function = FALSE

	'' LINE
	if( lexGetToken( ) <> FB_TK_LINE ) then
		exit function
	end if

	'' INPUT
	if( lexGetLookAhead(1) <> FB_TK_INPUT ) then
		exit function
	end if

	lexSkipToken( )
	lexSkipToken( )

	'' ';'?
	if( hMatch( CHAR_SEMICOLON ) ) then
		addnewline = FALSE
	else
		addnewline = TRUE
	end if

	'' '#'?
	isfile = FALSE
	if( hMatch( CHAR_SHARP ) ) then
		isfile = TRUE
	end if

	'' Expression?
	if( not cExpression( expr ) ) then
		if( isfile ) then
			hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
			exit function
		end if
		expr = NULL
	end if

	'' ','|';'?
	issep = TRUE
	if( not hMatch( CHAR_COMMA ) ) then
		if( not hMatch( CHAR_SEMICOLON ) ) then
			issep = FALSE
			if( (expr = NULL) or (isfile) ) then
				hReportError( FB_ERRMSG_EXPECTEDCOMMA )
				exit function
			end if
        else
        	addquestion = TRUE
		end if
    else
        addquestion = FALSE
	end if

    '' Variable?
	if( not cVarOrDeref( dstexpr ) ) then
       	if( (expr = NULL) or (isfile) ) then
       		hReportError( FB_ERRMSG_EXPECTEDIDENTIFIER )
       		exit function
       	end if
       	dstexpr = expr
       	expr = NULL
    else
    	if( issep = FALSE ) then
			hReportError( FB_ERRMSG_EXPECTEDCOMMA )
			exit function
    	end if
    end if

    '' not a string?
    if( not hIsString( astGetDataType( dstexpr ) ) ) then
		hReportError( FB_ERRMSG_INVALIDDATATYPES )
		exit function
    end if

    function = rtlFileLineInput( isfile, expr, dstexpr, addquestion, addnewline )

end function

'':::::
'' InputStmt	  =   INPUT ';'? (('#' Expression| STRING_LIT) (','|';'))? Variable (',' Variable)*
''
function cInputStmt as integer
    dim as ASTNODE ptr filestrexpr, dstexpr
    dim as integer iscomma, isfile, addnewline, addquestion, lgt

	function = FALSE

	'' INPUT
	if( not hMatch( FB_TK_INPUT ) ) then
		exit function
	end if

	'' ';'?
	if( hMatch( CHAR_SEMICOLON ) ) then
		addnewline = FALSE
	else
		addnewline = TRUE
	end if

	'' '#'?
	if( hMatch( CHAR_SHARP ) ) then
		isfile = TRUE
		'' Expression
		hMatchExpression( filestrexpr )

    else
    	isfile = FALSE
    	'' STRING_LIT?
    	if( lexGetClass = FB_TKCLASS_STRLITERAL ) then
			lgt = lexGetTextLen( )
			filestrexpr = astNewVAR( hAllocStringConst( *lexGetText( ), lgt ), _
									 NULL, 0, IR_DATATYPE_FIXSTR )
			lexSkipToken( )
    	else
    		filestrexpr = NULL
    	end if
	end if

	'' ','|';'
	addquestion = FALSE
	if( (isfile) or (filestrexpr <> NULL) ) then
		if( not hMatch( CHAR_COMMA ) ) then
			if( not hMatch( CHAR_SEMICOLON ) ) then
				hReportError FB_ERRMSG_EXPECTEDCOMMA
				exit function
			else
				addquestion = TRUE
			end if
		end if
	end if

	''
	if( not rtlFileInput( isfile, filestrexpr, addquestion, addnewline ) ) then
		exit function
	end if

    '' Variable (',' Variable)*
    do
		if( not cVarOrDeref( dstexpr ) ) then
       		hReportError FB_ERRMSG_EXPECTEDIDENTIFIER
       		exit function
       	end if

		iscomma = FALSE
		if( hMatch( CHAR_COMMA ) ) then
			iscomma = TRUE
		end if

    	if( not rtlFileInputGet( dstexpr ) ) then
			exit function
		end if
    loop while( iscomma )

    function = TRUE

end function

'':::::
private function hFileClose( byval isfunc as integer ) as ASTNODE ptr
	dim as integer cnt
	dim as ASTNODE ptr filenum, proc

	function = NULL

	'' CLOSE
	lexSkipToken

	if( isfunc ) then
		'' '('
		hMatchLPRNT( )
	end if

	cnt = 0
	do
		hMatch( CHAR_SHARP )

    	if( not cExpression( filenum ) ) then
			if( cnt = 0 ) then
				filenum = astNewCONSTi( 0, IR_DATATYPE_INTEGER )
			else
				hReportError FB_ERRMSG_EXPECTEDEXPRESSION
				exit function
			end if
		end if

		proc = rtlFileClose( filenum, isfunc )
		if( proc = NULL ) then
			exit function
		end if

		if( isfunc ) then
			exit do
		end if

		cnt += 1

	loop while( hMatch( CHAR_COMMA ) )

	if( isfunc ) then
		'' ')'
		hMatchRPRNT( )
	end if

	function = proc

end function

'':::::
private function hFilePut( byval isfunc as integer ) as ASTNODE ptr
	dim as ASTNODE ptr filenum, expr1, expr2
	dim as integer isarray
	dim as FBSYMBOL ptr s

	function = NULL

	'' '#'?
	if( lexGetToken = CHAR_SHARP ) then
		lexSkipToken
	end if

	hMatchExpression( filenum )

	hMatchCOMMA( )

	if( not cExpression( expr1 ) ) then
		expr1 = NULL
	end if

	hMatchCOMMA( )

	hMatchExpression( expr2 )

	'' don't allow literal values, due the way "byref as
	'' any" args work (ie, the VB-way: literals are passed by value)
	if( astIsCONST( expr2 ) or astIsOFFSET( expr2 ) ) then
		hReportError( FB_ERRMSG_EXPECTEDIDENTIFIER, TRUE )
		exit function
	end if

    isarray = FALSE
    if( lexGetToken( ) = CHAR_LPRNT ) then
    	if( lexGetLookAhead(1) = CHAR_RPRNT ) then
    		s = astGetSymbolOrElm( expr2 )
    		if( s <> NULL ) then
    			isarray = symbIsArray( s )
    			if( isarray ) then
    				'' don't allow var-len strings
    				if( symbGetType( s ) = FB_SYMBTYPE_STRING ) then
						hReportError( FB_ERRMSG_INVALIDDATATYPES, TRUE )
						exit function
    				end if
    				lexSkipToken( )
    				lexSkipToken( )
    			end if
    		end if
    	end if
    end if

	if( not isarray ) then
		function = rtlFilePut( filenum, expr1, expr2, isfunc )
	else
		function = rtlFilePutArray( filenum, expr1, expr2, isfunc )
	end if

end function

'':::::
private function hFileGet( byval isfunc as integer ) as ASTNODE ptr
	dim as ASTNODE ptr filenum, expr1, expr2
	dim as integer isarray
	dim as FBSYMBOL ptr s

	function = NULL

	'' '#'?
	if( lexGetToken = CHAR_SHARP ) then
		lexSkipToken
	end if

	hMatchExpression( filenum )

	hMatchCOMMA( )

	if( not cExpression( expr1 ) ) then
		expr1 = NULL
	end if

	hMatchCOMMA( )

	if( not cVarOrDeref( expr2 ) ) then
		hReportError FB_ERRMSG_EXPECTEDIDENTIFIER
		exit function
	end if

    isarray = FALSE
    if( lexGetToken( ) = CHAR_LPRNT ) then
    	if( lexGetLookAhead(1) = CHAR_RPRNT ) then
    		s = astGetSymbolOrElm( expr2 )
    		if( s <> NULL ) then
    			isarray = symbIsArray( s )
    			if( isarray ) then
    				'' don't allow var-len strings
    				if( symbGetType( s ) = FB_SYMBTYPE_STRING ) then
						hReportError( FB_ERRMSG_INVALIDDATATYPES, TRUE )
						exit function
    				end if
    				lexSkipToken( )
    				lexSkipToken( )
    			end if
    		end if
    	end if
    end if

	if( not isarray ) then
		function = rtlFileGet( filenum, expr1, expr2, isfunc )
	else
		function = rtlFileGetArray( filenum, expr1, expr2, isfunc )
	end if

end function

'':::::
private function hFileOpen( byval isfunc as integer ) as ASTNODE ptr
	dim as ASTNODE ptr filenum, filename, fmode, faccess, flock, flen
    dim as integer short_form
	dim as integer file_mode, access_mode, lock_mode, record_len
    dim as FBOPENKIND open_kind

	function = NULL

    open_kind = FB_FILE_TYPE_FILE

    short_form = FALSE

	'' special devices
	select case ucase$( *lexGetText( ) )
    case "CONS"
		'' not a symbol?
		if( lexGetSymbol( ) = NULL ) then
			lexSkipToken( )
    		open_kind = FB_FILE_TYPE_CONS
    	end if

    case "ERR"
		lexSkipToken( )
        open_kind = FB_FILE_TYPE_ERR

    case "PIPE"
		'' not a symbol?
		if( lexGetSymbol( ) = NULL ) then
			lexSkipToken( )
        	open_kind = FB_FILE_TYPE_PIPE
        end if

    case "SCRN"
		'' not a symbol?
		if( lexGetSymbol( ) = NULL ) then
			lexSkipToken( )
        	open_kind = FB_FILE_TYPE_SCRN
        end if

    case "LPT"
		'' not a symbol?
		if( lexGetSymbol( ) = NULL ) then
			lexSkipToken( )
    		open_kind = FB_FILE_TYPE_LPT
    	end if

    case "COM"
		'' not a symbol?
		if( lexGetSymbol( ) = NULL ) then
			lexSkipToken( )
    		open_kind = FB_FILE_TYPE_COM
    	end if
    end select

	if( isfunc ) then
		'' '('
		hMatchLPRNT( )
	end if

    select case open_kind
    case FB_FILE_TYPE_FILE, FB_FILE_TYPE_PIPE, FB_FILE_TYPE_LPT, FB_FILE_TYPE_COM
        '' a filename is only valid for some file types

		hMatchExpression( filename )

        if( isfunc ) then
            '' ','?
            hMatch( CHAR_COMMA )
        end if

        ' only test for short OPEN form when using the "normal" OPEN
        if open_kind = FB_FILE_TYPE_FILE then
	        if( isfunc ) then
                select case lexGetToken
                case FB_TK_FOR, FB_TK_ACCESS, FB_TK_AS
                case else
                    short_form = TRUE
                end select
	        else
	            if( hMatch( CHAR_COMMA ) ) then
	                '' ',' -> indicates the short form
	                short_form = TRUE
	            end if
            end if
        end if

    case else

        ' no file name provided for this kind of OPEN statmenets
    	filename = astNewCONSTs( "" )

    end select

    if( short_form ) then
        '' file mode ("I"|"O"|"A"|"B"|"R")
        fmode = filename
        filename = NULL

        '' '#'? file number
        hMatch( CHAR_SHARP )
        hMatchExpression( filenum )

        hMatchCOMMA( )
        '' file name
        hMatchExpression( filename )

        '' record length
        if( hMatch( CHAR_COMMA ) ) then
            if( lexGetToken <> CHAR_COMMA ) then
            	hMatchExpression( flen )
            end if
            '' access mode
            if( hMatch( CHAR_COMMA ) ) then
                if( lexGetToken <> CHAR_COMMA ) then
                    hMatchExpression( faccess )
                end if
                '' lock mode
                if( hMatch( CHAR_COMMA ) ) then
                	hMatchExpression( flock )
                end if
            end if
        end if
        if( flen = NULL ) then flen = astNewCONSTi( 0, IR_DATATYPE_INTEGER )
        if( faccess = NULL ) then faccess = astNewCONSTs( "" )
        if( flock = NULL ) then flock = astNewCONSTs( "" )
    else
        '' (FOR (INPUT|OUTPUT|BINARY|RANDOM|APPEND))?
        if( hMatch( FB_TK_FOR ) ) then
            select case lexGetToken
            case FB_TK_INPUT
                file_mode = FB_FILE_MODE_INPUT
            case FB_TK_OUTPUT
                file_mode = FB_FILE_MODE_OUTPUT
            case FB_TK_BINARY
                file_mode = FB_FILE_MODE_BINARY
            case FB_TK_RANDOM
                file_mode = FB_FILE_MODE_RANDOM
            case FB_TK_APPEND
                file_mode = FB_FILE_MODE_APPEND
            case else
                exit function
            end select
            lexSkipToken

        else
            file_mode = FB_FILE_MODE_RANDOM
        end if

        fmode = astNewCONSTi( file_mode, IR_DATATYPE_INTEGER )

        if( isfunc ) then
            '' ','?
            hMatch( CHAR_COMMA )
        end if

        '' (ACCESS (READ|WRITE|READ WRITE))?
        if( hMatch( FB_TK_ACCESS ) ) then
            select case lexGetToken
            case FB_TK_WRITE
                lexSkipToken
                access_mode = FB_FILE_ACCESS_WRITE
            case FB_TK_READ
                lexSkipToken
                if( hMatch( FB_TK_WRITE ) ) then
                    access_mode = FB_FILE_ACCESS_READWRITE
                else
                    access_mode = FB_FILE_ACCESS_READ
                end if
            end select
        else
            access_mode = FB_FILE_ACCESS_ANY
        end if

        faccess = astNewCONSTi( access_mode, IR_DATATYPE_INTEGER )

        if( isfunc ) then
            '' ','?
            hMatch( CHAR_COMMA )
        end if

        '' (SHARED|LOCK (READ|WRITE|READ WRITE))?
        if( hMatch( FB_TK_SHARED ) ) then
            lock_mode = FB_FILE_LOCK_SHARED
        elseif( hMatch( FB_TK_LOCK ) ) then
            select case lexGetToken
            case FB_TK_WRITE
                lexSkipToken
                lock_mode = FB_FILE_LOCK_WRITE
            case FB_TK_READ
                lexSkipToken
                if( hMatch( FB_TK_WRITE ) ) then
                    lock_mode = FB_FILE_LOCK_READWRITE
                else
                    lock_mode = FB_FILE_LOCK_READ
                end if
            end select
        else
            lock_mode = FB_FILE_LOCK_SHARED
        end if

        flock = astNewCONSTi( lock_mode, IR_DATATYPE_INTEGER )

        if( isfunc ) then
            '' ','?
            hMatch( CHAR_COMMA )
        end if

        '' AS '#'? Expression
        if( not hMatch( FB_TK_AS ) ) then
            hReportError FB_ERRMSG_EXPECTINGAS
            exit function
        end if

        hMatch( CHAR_SHARP )

        hMatchExpression( filenum )

        if( isfunc ) then
            '' ','?
            hMatch( CHAR_COMMA )
        end if

        '' (LEN '=' Expression)?
        if( hMatch( FB_TK_LEN ) ) then
            if( not hMatch( FB_TK_ASSIGN ) ) then
                hReportError FB_ERRMSG_EXPECTEDEQ
                exit function
            end if
            hMatchExpression( flen )
        else
            flen = astNewCONSTi( 0, IR_DATATYPE_INTEGER )
        end if

    end if

    if( isfunc ) then
        '' ')'
        hMatchRPRNT( )
    end if

	''
	function = rtlFileOpen( filename, fmode, faccess, flock, _
							filenum, flen, isfunc, open_kind )

end function

'':::::
private function hFileRename( byval isfunc as integer ) as ASTNODE ptr
	dim as ASTNODE ptr filename_old, filename_new
	dim as integer matchprnt

	function = NULL

	'' '('
    if( isfunc ) then
		hMatchLPRNT( )
    else
		'' '('?
       	matchprnt = hMatch( CHAR_LPRNT )
    end if

	hMatchExpression( filename_old )

	if( isfunc ) then
		'' ','?
		hMatchCOMMA( )
    else
        if( not hMatch( FB_TK_AS ) ) then
        	if( not hMatch( CHAR_COMMA ) ) then
                hReportError FB_ERRMSG_EXPECTINGAS
                exit function
            end if
        end if
	end if

	hMatchExpression( filename_new )

	if( isfunc or matchprnt ) then
		'' ')'
		hMatchRPRNT( )
	end if

	''
	function = rtlFileRename( filename_new, filename_old, isfunc )

end function

'':::::
'' FileStmt		  =	   OPEN Expression{str} (FOR (INPUT|OUTPUT|BINARY|RANDOM|APPEND))? (ACCESS Expression)?
''					   (SHARED|LOCK (READ|WRITE|READ WRITE))? AS '#'? Expression (LEN '=' Expression)?
''                |    OPEN ("O"|"I"|"B"|"R"|"A")',' '#'? Expression{int} ',' Expression{str}
''                     (',' Expression{int}? (',' Expression{str}? (',' Expression{str})? )? )?
''				  |	   CLOSE ('#'? Expression)*
''				  |	   SEEK '#'? Expression ',' Expression
''				  |	   PUT '#' Expression ',' Expression? ',' Expression{str|int|float|array}
''				  |	   GET '#' Expression ',' Expression? ',' Variable{str|int|float|array}
''				  |    (LOCK|UNLOCK) '#'? Expression, Expression (TO Expression)? .
function cFileStmt as integer
    dim as ASTNODE ptr filenum, expr1, expr2
    dim as integer islock

	function = FALSE

	select case as const lexGetToken
	'' OPEN Expression{str} (FOR Expression)? (ACCESS Expression)?
	'' (SHARED|LOCK (READ|WRITE|READ WRITE))? AS '#'? Expression (LEN '=' Expression)?
    ''
    '' or:
    ''
    '' OPEN ("O"|"I"|"B"|"R"|"A")',' '#'? Expression{int}',' Expression{str} (',' Expression{int})?
	case FB_TK_OPEN
		lexSkipToken

		function = (hFileOpen( FALSE ) <> NULL)


	'' CLOSE ('#'? Expression)*
	case FB_TK_CLOSE

		function = (hFileClose( FALSE ) <> NULL)

	'' SEEK '#'? Expression ',' Expression
	case FB_TK_SEEK
		lexSkipToken
		hMatch( CHAR_SHARP )

		hMatchExpression( filenum )

		hMatchCOMMA( )

		hMatchExpression( expr1 )

		function = rtlFileSeek( filenum, expr1 )

	'' PUT '#' Expression ',' Expression? ',' Expression{str|int|float|array}
	case FB_TK_PUT
		if( lexGetLookAhead(1) <> CHAR_SHARP ) then
			exit function
		end if

		lexSkipToken( )

        function = (hFilePut( FALSE ) <> NULL)

	'' GET '#' Expression ',' Expression? ',' Variable{str|int|float|array}
	case FB_TK_GET
		if( lexGetLookAhead(1) <> CHAR_SHARP ) then
			exit function
		end if

		lexSkipToken

		function = (hFileGet( FALSE ) <> NULL)

	'' (LOCK|UNLOCK) '#'? Expression, Expression (TO Expression)?
	case FB_TK_LOCK, FB_TK_UNLOCK
		if( lexGetToken = FB_TK_LOCK ) then
			islock = TRUE
		else
			islock = FALSE
		end if

		lexSkipToken
		hMatch( CHAR_SHARP )

		hMatchExpression( filenum )

		hMatchCOMMA( )

		hMatchExpression( expr1 )

		if( hMatch( FB_TK_TO ) ) then
			hMatchExpression( expr2 )
		else
			expr2 = astNewCONSTi( 0, IR_DATATYPE_INTEGER )
		end if

		function = rtlFileLock( islock, filenum, expr1, expr2 )

    '' NAME oldfilespec$ AS newfilespec$
    case FB_TK_NAME
		lexSkipToken

		function = (hFileRename( FALSE ) <> NULL)

	end select

end function

'':::::
'' FileFunct =   SEEK '(' Expression ')' |
''				 INPUT '(' Expr, (',' '#'? Expr)? ')'.
''
function cFileFunct( byref funcexpr as ASTNODE ptr ) as integer
	dim as ASTNODE ptr filenum, expr

	function = FALSE

	'' SEEK '(' Expression ')'
	select case as const lexGetToken
	case FB_TK_SEEK
		lexSkipToken

		hMatchLPRNT( )

		hMatchExpression( filenum )

		hMatchRPRNT( )

		funcexpr = rtlFileTell( filenum )

		function = funcexpr <> NULL

	'' INPUT '(' Expr (',' '#'? Expr)? ')'
	case FB_TK_INPUT
		lexSkipToken

		hMatchLPRNT( )

		hMatchExpression( expr )

		if( hMatch( CHAR_COMMA ) ) then
			hMatch( CHAR_SHARP )

			hMatchExpression( filenum )
		else
			filenum = astNewCONSTi( 0, IR_DATATYPE_INTEGER )
		end if

		hMatchRPRNT( )

		funcexpr = rtlFileStrInput( expr, filenum )

		function = funcexpr <> NULL

	'' OPEN '(' ... ')'
	case FB_TK_OPEN
		lexSkipToken

		funcexpr = hFileOpen( TRUE )
		function = funcexpr <> NULL

	'' CLOSE '(' '#'? Expr? ')'
	case FB_TK_CLOSE

		funcexpr = hFileClose( TRUE )
		function = funcexpr <> NULL

	'' PUT '(' '#'? Expr, Expr?, Expr ')'
	case FB_TK_PUT
		lexSkipToken

		hMatchLPRNT( )

		funcexpr = hFilePut( TRUE )
		function = funcexpr <> NULL

		hMatchRPRNT( )

	'' GET '(' '#'? Expr, Expr?, Expr ')'
	case FB_TK_GET
		lexSkipToken

		hMatchLPRNT( )

		funcexpr = hFileGet( TRUE )
		function = funcexpr <> NULL

		hMatchRPRNT( )

    '' NAME '(' oldfilespec$ ',' newfilespec$ ')'
    case FB_TK_NAME
		lexSkipToken

		funcexpr = hFileRename( TRUE )
		function = funcexpr <> NULL

	end select

end function

