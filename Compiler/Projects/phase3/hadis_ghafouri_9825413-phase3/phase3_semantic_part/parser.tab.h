/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_PARSER_TAB_H_INCLUDED
# define YY_YY_PARSER_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    TOKEN_ID = 258,                /* TOKEN_ID  */
    TOKEN_DECIMALCONST = 259,      /* TOKEN_DECIMALCONST  */
    TOKEN_CHARCONST = 260,         /* TOKEN_CHARCONST  */
    TOKEN_HEXADECIMALCONST = 261,  /* TOKEN_HEXADECIMALCONST  */
    TOKEN_STRINGCONST = 262,       /* TOKEN_STRINGCONST  */
    TOKEN_BOOLEANCONST = 263,      /* TOKEN_BOOLEANCONST  */
    TOKEN_PROGRAMCLASS = 264,      /* TOKEN_PROGRAMCLASS  */
    TOKEN_MAINFUNC = 265,          /* TOKEN_MAINFUNC  */
    TOKEN_BREAKSTMT = 266,         /* TOKEN_BREAKSTMT  */
    TOKEN_CALLOUT = 267,           /* TOKEN_CALLOUT  */
    TOKEN_CLASS = 268,             /* TOKEN_CLASS  */
    TOKEN_CONTINUESTMT = 269,      /* TOKEN_CONTINUESTMT  */
    TOKEN_VOIDTYPE = 270,          /* TOKEN_VOIDTYPE  */
    TOKEN_BOOLEANTYPE = 271,       /* TOKEN_BOOLEANTYPE  */
    TOKEN_INTTYPE = 272,           /* TOKEN_INTTYPE  */
    TOKEN_IFCONDITION = 273,       /* TOKEN_IFCONDITION  */
    TOKEN_ELSECONDITION = 274,     /* TOKEN_ELSECONDITION  */
    TOKEN_LOOP = 275,              /* TOKEN_LOOP  */
    TOKEN_RETURN = 276,            /* TOKEN_RETURN  */
    TOKEN_LP = 277,                /* TOKEN_LP  */
    TOKEN_RP = 278,                /* TOKEN_RP  */
    TOKEN_LCB = 279,               /* TOKEN_LCB  */
    TOKEN_RCB = 280,               /* TOKEN_RCB  */
    TOKEN_LB = 281,                /* TOKEN_LB  */
    TOKEN_RB = 282,                /* TOKEN_RB  */
    TOKEN_SEMICOLON = 283,         /* TOKEN_SEMICOLON  */
    TOKEN_COMMA = 284,             /* TOKEN_COMMA  */
    TOKEN_LOGICOP = 285,           /* TOKEN_LOGICOP  */
    TOKEN_NOTEQUAL = 286,          /* TOKEN_NOTEQUAL  */
    TOKEN_EQUAL = 287,             /* TOKEN_EQUAL  */
    TOKEN_AND = 288,               /* TOKEN_AND  */
    TOKEN_OR = 289,                /* TOKEN_OR  */
    TOKEN_ASSIGNOP = 290,          /* TOKEN_ASSIGNOP  */
    TOKEN_MINUS_EQUAL = 291,       /* TOKEN_MINUS_EQUAL  */
    TOKEN_PLUS_EQUAL = 292,        /* TOKEN_PLUS_EQUAL  */
    TOKEN_PLUS = 293,              /* TOKEN_PLUS  */
    TOKEN_MINUS = 294,             /* TOKEN_MINUS  */
    TOKEN_MULTIPLICATION = 295,    /* TOKEN_MULTIPLICATION  */
    TOKEN_DIVISION = 296,          /* TOKEN_DIVISION  */
    TOKEN_MODULO = 297,            /* TOKEN_MODULO  */
    TOKEN_GREATER_EQUAL = 298,     /* TOKEN_GREATER_EQUAL  */
    TOKEN_LESS_EQUAL = 299,        /* TOKEN_LESS_EQUAL  */
    TOKEN_GREATER = 300,           /* TOKEN_GREATER  */
    TOKEN_LESS = 301               /* TOKEN_LESS  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 78 "parser.y"

	char* str_val;
	int int_val;
	bool bool_val;	
	char char_val;	
	struct ExprStruct* Expr;
	struct ArgsStruct* Args;	

#line 119 "parser.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_PARSER_TAB_H_INCLUDED  */
