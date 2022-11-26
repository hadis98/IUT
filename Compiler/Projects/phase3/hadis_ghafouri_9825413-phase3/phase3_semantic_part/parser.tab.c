/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison implementation for Yacc-like parsers in C

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

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output, and Bison version.  */
#define YYBISON 30802

/* Bison version string.  */
#define YYBISON_VERSION "3.8.2"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* First part of user prologue.  */
#line 1 "parser.y"

	#include <iostream>
	#include <stdlib.h>
	#include <string.h>
	#include <vector>
	#include <cstdlib>
	#include <string>
	#include <math.h>	
	#include <stack>
	#include <sstream>	

	using namespace std;	
	
	void yyerror(string error_message);
	extern int yylex();
	extern int numLines;
	extern FILE * yyin;
	extern FILE *outputFile;
 	FILE* MIPS_FILE;

	string field_type="";
	string var_type="";
	string current_func="";
	string currentScope="global";	
	void pushSymbol(string,string,string,string,bool,int);
	void pushFunction(string,string,int, string*);
	struct Symbol* getSymbol(string name,string scope,bool is_array = false);
	struct Function* getFunction(string);
	string getNewRegister(char);
  	void releaseRegister(string);
  	int convertStringToInt(string);
	string convertToString(int);
  	stack <string> Stack;
  	int Label = 0;//used to index labels
  	int forLabel = 0;//used to index loop_labels  	

  struct Symbol{
    string name;
    string symbol_type;
    string scope;
    string reg;
	//*for array variables
	bool is_array= false;
	int array_size;
  };

  struct Function{
    string name;
    string return_type;
    int num_args;
    string* args_types; 
  };
     struct ArgsStruct{
  	int num_args;
  	string* args_types;
  };
    struct ExprStruct{
  	string expr_type; //'boolean' or 'int' or 'char'
	bool expr_val_bool; 	
	int expr_val_int;
	char expr_val_char;
  };
  
  vector <struct Symbol*> symbols;
  vector <struct Function*> functions;


  string t_registers[10] = {"$t0","$t1","$t2","$t3","$t4","$t5","$t6","$t7","$t8","$t9"};
  bool t_registers_state[10] = {0};  
  string s_registers[8] = {"$s0","$s1","$s2","$s3","$s4","$s5","$s6","$s7"};
  bool s_registers_state[8] = {0};  
  string a_registers[4] = {"$a0","$a1","$a2","$a3"};
  bool a_registers_state[4] = {0};  
  string v_registers[2] = {"$v0","$v1"};

#line 147 "parser.tab.c"

# ifndef YY_CAST
#  ifdef __cplusplus
#   define YY_CAST(Type, Val) static_cast<Type> (Val)
#   define YY_REINTERPRET_CAST(Type, Val) reinterpret_cast<Type> (Val)
#  else
#   define YY_CAST(Type, Val) ((Type) (Val))
#   define YY_REINTERPRET_CAST(Type, Val) ((Type) (Val))
#  endif
# endif
# ifndef YY_NULLPTR
#  if defined __cplusplus
#   if 201103L <= __cplusplus
#    define YY_NULLPTR nullptr
#   else
#    define YY_NULLPTR 0
#   endif
#  else
#   define YY_NULLPTR ((void*)0)
#  endif
# endif

#include "parser.tab.h"
/* Symbol kind.  */
enum yysymbol_kind_t
{
  YYSYMBOL_YYEMPTY = -2,
  YYSYMBOL_YYEOF = 0,                      /* "end of file"  */
  YYSYMBOL_YYerror = 1,                    /* error  */
  YYSYMBOL_YYUNDEF = 2,                    /* "invalid token"  */
  YYSYMBOL_TOKEN_ID = 3,                   /* TOKEN_ID  */
  YYSYMBOL_TOKEN_DECIMALCONST = 4,         /* TOKEN_DECIMALCONST  */
  YYSYMBOL_TOKEN_CHARCONST = 5,            /* TOKEN_CHARCONST  */
  YYSYMBOL_TOKEN_HEXADECIMALCONST = 6,     /* TOKEN_HEXADECIMALCONST  */
  YYSYMBOL_TOKEN_STRINGCONST = 7,          /* TOKEN_STRINGCONST  */
  YYSYMBOL_TOKEN_BOOLEANCONST = 8,         /* TOKEN_BOOLEANCONST  */
  YYSYMBOL_TOKEN_PROGRAMCLASS = 9,         /* TOKEN_PROGRAMCLASS  */
  YYSYMBOL_TOKEN_MAINFUNC = 10,            /* TOKEN_MAINFUNC  */
  YYSYMBOL_TOKEN_BREAKSTMT = 11,           /* TOKEN_BREAKSTMT  */
  YYSYMBOL_TOKEN_CALLOUT = 12,             /* TOKEN_CALLOUT  */
  YYSYMBOL_TOKEN_CLASS = 13,               /* TOKEN_CLASS  */
  YYSYMBOL_TOKEN_CONTINUESTMT = 14,        /* TOKEN_CONTINUESTMT  */
  YYSYMBOL_TOKEN_VOIDTYPE = 15,            /* TOKEN_VOIDTYPE  */
  YYSYMBOL_TOKEN_BOOLEANTYPE = 16,         /* TOKEN_BOOLEANTYPE  */
  YYSYMBOL_TOKEN_INTTYPE = 17,             /* TOKEN_INTTYPE  */
  YYSYMBOL_TOKEN_IFCONDITION = 18,         /* TOKEN_IFCONDITION  */
  YYSYMBOL_TOKEN_ELSECONDITION = 19,       /* TOKEN_ELSECONDITION  */
  YYSYMBOL_TOKEN_LOOP = 20,                /* TOKEN_LOOP  */
  YYSYMBOL_TOKEN_RETURN = 21,              /* TOKEN_RETURN  */
  YYSYMBOL_TOKEN_LP = 22,                  /* TOKEN_LP  */
  YYSYMBOL_TOKEN_RP = 23,                  /* TOKEN_RP  */
  YYSYMBOL_TOKEN_LCB = 24,                 /* TOKEN_LCB  */
  YYSYMBOL_TOKEN_RCB = 25,                 /* TOKEN_RCB  */
  YYSYMBOL_TOKEN_LB = 26,                  /* TOKEN_LB  */
  YYSYMBOL_TOKEN_RB = 27,                  /* TOKEN_RB  */
  YYSYMBOL_TOKEN_SEMICOLON = 28,           /* TOKEN_SEMICOLON  */
  YYSYMBOL_TOKEN_COMMA = 29,               /* TOKEN_COMMA  */
  YYSYMBOL_TOKEN_LOGICOP = 30,             /* TOKEN_LOGICOP  */
  YYSYMBOL_TOKEN_NOTEQUAL = 31,            /* TOKEN_NOTEQUAL  */
  YYSYMBOL_TOKEN_EQUAL = 32,               /* TOKEN_EQUAL  */
  YYSYMBOL_TOKEN_AND = 33,                 /* TOKEN_AND  */
  YYSYMBOL_TOKEN_OR = 34,                  /* TOKEN_OR  */
  YYSYMBOL_TOKEN_ASSIGNOP = 35,            /* TOKEN_ASSIGNOP  */
  YYSYMBOL_TOKEN_MINUS_EQUAL = 36,         /* TOKEN_MINUS_EQUAL  */
  YYSYMBOL_TOKEN_PLUS_EQUAL = 37,          /* TOKEN_PLUS_EQUAL  */
  YYSYMBOL_TOKEN_PLUS = 38,                /* TOKEN_PLUS  */
  YYSYMBOL_TOKEN_MINUS = 39,               /* TOKEN_MINUS  */
  YYSYMBOL_TOKEN_MULTIPLICATION = 40,      /* TOKEN_MULTIPLICATION  */
  YYSYMBOL_TOKEN_DIVISION = 41,            /* TOKEN_DIVISION  */
  YYSYMBOL_TOKEN_MODULO = 42,              /* TOKEN_MODULO  */
  YYSYMBOL_TOKEN_GREATER_EQUAL = 43,       /* TOKEN_GREATER_EQUAL  */
  YYSYMBOL_TOKEN_LESS_EQUAL = 44,          /* TOKEN_LESS_EQUAL  */
  YYSYMBOL_TOKEN_GREATER = 45,             /* TOKEN_GREATER  */
  YYSYMBOL_TOKEN_LESS = 46,                /* TOKEN_LESS  */
  YYSYMBOL_YYACCEPT = 47,                  /* $accept  */
  YYSYMBOL_program = 48,                   /* program  */
  YYSYMBOL_49_1 = 49,                      /* $@1  */
  YYSYMBOL_decl_fields = 50,               /* decl_fields  */
  YYSYMBOL_decl_field = 51,                /* decl_field  */
  YYSYMBOL_names = 52,                     /* names  */
  YYSYMBOL_decl_methods = 53,              /* decl_methods  */
  YYSYMBOL_decl_method = 54,               /* decl_method  */
  YYSYMBOL_55_2 = 55,                      /* $@2  */
  YYSYMBOL_56_3 = 56,                      /* $@3  */
  YYSYMBOL_57_4 = 57,                      /* $@4  */
  YYSYMBOL_58_5 = 58,                      /* $@5  */
  YYSYMBOL_method_id = 59,                 /* method_id  */
  YYSYMBOL_block = 60,                     /* block  */
  YYSYMBOL_declare_vars = 61,              /* declare_vars  */
  YYSYMBOL_declare_var = 62,               /* declare_var  */
  YYSYMBOL_63_6 = 63,                      /* $@6  */
  YYSYMBOL_64_7 = 64,                      /* $@7  */
  YYSYMBOL_ids = 65,                       /* ids  */
  YYSYMBOL_66_8 = 66,                      /* $@8  */
  YYSYMBOL_type = 67,                      /* type  */
  YYSYMBOL_statments = 68,                 /* statments  */
  YYSYMBOL_statment = 69,                  /* statment  */
  YYSYMBOL_70_9 = 70,                      /* $@9  */
  YYSYMBOL_71_10 = 71,                     /* $@10  */
  YYSYMBOL_method_call = 72,               /* method_call  */
  YYSYMBOL_call_params = 73,               /* call_params  */
  YYSYMBOL_method_args = 74,               /* method_args  */
  YYSYMBOL_method_arg = 75,                /* method_arg  */
  YYSYMBOL_optional_callout_args = 76,     /* optional_callout_args  */
  YYSYMBOL_callout_args = 77,              /* callout_args  */
  YYSYMBOL_expr = 78,                      /* expr  */
  YYSYMBOL_stmt_if = 79,                   /* stmt_if  */
  YYSYMBOL_80_11 = 80,                     /* $@11  */
  YYSYMBOL_81_12 = 81,                     /* $@12  */
  YYSYMBOL_82_13 = 82,                     /* $@13  */
  YYSYMBOL_optional_else = 83,             /* optional_else  */
  YYSYMBOL_stmt_for = 84,                  /* stmt_for  */
  YYSYMBOL_85_14 = 85,                     /* $@14  */
  YYSYMBOL_86_15 = 86,                     /* $@15  */
  YYSYMBOL_87_16 = 87,                     /* $@16  */
  YYSYMBOL_stmt_return = 88,               /* stmt_return  */
  YYSYMBOL_callout_arg = 89                /* callout_arg  */
};
typedef enum yysymbol_kind_t yysymbol_kind_t;




#ifdef short
# undef short
#endif

/* On compilers that do not define __PTRDIFF_MAX__ etc., make sure
   <limits.h> and (if available) <stdint.h> are included
   so that the code can choose integer types of a good width.  */

#ifndef __PTRDIFF_MAX__
# include <limits.h> /* INFRINGES ON USER NAME SPACE */
# if defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stdint.h> /* INFRINGES ON USER NAME SPACE */
#  define YY_STDINT_H
# endif
#endif

/* Narrow types that promote to a signed type and that can represent a
   signed or unsigned integer of at least N bits.  In tables they can
   save space and decrease cache pressure.  Promoting to a signed type
   helps avoid bugs in integer arithmetic.  */

#ifdef __INT_LEAST8_MAX__
typedef __INT_LEAST8_TYPE__ yytype_int8;
#elif defined YY_STDINT_H
typedef int_least8_t yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef __INT_LEAST16_MAX__
typedef __INT_LEAST16_TYPE__ yytype_int16;
#elif defined YY_STDINT_H
typedef int_least16_t yytype_int16;
#else
typedef short yytype_int16;
#endif

/* Work around bug in HP-UX 11.23, which defines these macros
   incorrectly for preprocessor constants.  This workaround can likely
   be removed in 2023, as HPE has promised support for HP-UX 11.23
   (aka HP-UX 11i v2) only through the end of 2022; see Table 2 of
   <https://h20195.www2.hpe.com/V2/getpdf.aspx/4AA4-7673ENW.pdf>.  */
#ifdef __hpux
# undef UINT_LEAST8_MAX
# undef UINT_LEAST16_MAX
# define UINT_LEAST8_MAX 255
# define UINT_LEAST16_MAX 65535
#endif

#if defined __UINT_LEAST8_MAX__ && __UINT_LEAST8_MAX__ <= __INT_MAX__
typedef __UINT_LEAST8_TYPE__ yytype_uint8;
#elif (!defined __UINT_LEAST8_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST8_MAX <= INT_MAX)
typedef uint_least8_t yytype_uint8;
#elif !defined __UINT_LEAST8_MAX__ && UCHAR_MAX <= INT_MAX
typedef unsigned char yytype_uint8;
#else
typedef short yytype_uint8;
#endif

#if defined __UINT_LEAST16_MAX__ && __UINT_LEAST16_MAX__ <= __INT_MAX__
typedef __UINT_LEAST16_TYPE__ yytype_uint16;
#elif (!defined __UINT_LEAST16_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST16_MAX <= INT_MAX)
typedef uint_least16_t yytype_uint16;
#elif !defined __UINT_LEAST16_MAX__ && USHRT_MAX <= INT_MAX
typedef unsigned short yytype_uint16;
#else
typedef int yytype_uint16;
#endif

#ifndef YYPTRDIFF_T
# if defined __PTRDIFF_TYPE__ && defined __PTRDIFF_MAX__
#  define YYPTRDIFF_T __PTRDIFF_TYPE__
#  define YYPTRDIFF_MAXIMUM __PTRDIFF_MAX__
# elif defined PTRDIFF_MAX
#  ifndef ptrdiff_t
#   include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  endif
#  define YYPTRDIFF_T ptrdiff_t
#  define YYPTRDIFF_MAXIMUM PTRDIFF_MAX
# else
#  define YYPTRDIFF_T long
#  define YYPTRDIFF_MAXIMUM LONG_MAX
# endif
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned
# endif
#endif

#define YYSIZE_MAXIMUM                                  \
  YY_CAST (YYPTRDIFF_T,                                 \
           (YYPTRDIFF_MAXIMUM < YY_CAST (YYSIZE_T, -1)  \
            ? YYPTRDIFF_MAXIMUM                         \
            : YY_CAST (YYSIZE_T, -1)))

#define YYSIZEOF(X) YY_CAST (YYPTRDIFF_T, sizeof (X))


/* Stored state numbers (used for stacks). */
typedef yytype_uint8 yy_state_t;

/* State numbers in computations.  */
typedef int yy_state_fast_t;

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif


#ifndef YY_ATTRIBUTE_PURE
# if defined __GNUC__ && 2 < __GNUC__ + (96 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_PURE __attribute__ ((__pure__))
# else
#  define YY_ATTRIBUTE_PURE
# endif
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# if defined __GNUC__ && 2 < __GNUC__ + (7 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_UNUSED __attribute__ ((__unused__))
# else
#  define YY_ATTRIBUTE_UNUSED
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YY_USE(E) ((void) (E))
#else
# define YY_USE(E) /* empty */
#endif

/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
#if defined __GNUC__ && ! defined __ICC && 406 <= __GNUC__ * 100 + __GNUC_MINOR__
# if __GNUC__ * 100 + __GNUC_MINOR__ < 407
#  define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                           \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")
# else
#  define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                           \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")              \
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# endif
# define YY_IGNORE_MAYBE_UNINITIALIZED_END      \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif

#if defined __cplusplus && defined __GNUC__ && ! defined __ICC && 6 <= __GNUC__
# define YY_IGNORE_USELESS_CAST_BEGIN                          \
    _Pragma ("GCC diagnostic push")                            \
    _Pragma ("GCC diagnostic ignored \"-Wuseless-cast\"")
# define YY_IGNORE_USELESS_CAST_END            \
    _Pragma ("GCC diagnostic pop")
#endif
#ifndef YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_END
#endif


#define YY_ASSERT(E) ((void) (0 && (E)))

#if !defined yyoverflow

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* !defined yyoverflow */

#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yy_state_t yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (YYSIZEOF (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (YYSIZEOF (yy_state_t) + YYSIZEOF (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYPTRDIFF_T yynewbytes;                                         \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * YYSIZEOF (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / YYSIZEOF (*yyptr);                        \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, YY_CAST (YYSIZE_T, (Count)) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYPTRDIFF_T yyi;                      \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  4
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   471

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  47
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  43
/* YYNRULES -- Number of rules.  */
#define YYNRULES  102
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  194

/* YYMAXUTOK -- Last valid token kind.  */
#define YYMAXUTOK   301


/* YYTRANSLATE(TOKEN-NUM) -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, with out-of-bounds checking.  */
#define YYTRANSLATE(YYX)                                \
  (0 <= (YYX) && (YYX) <= YYMAXUTOK                     \
   ? YY_CAST (yysymbol_kind_t, yytranslate[YYX])        \
   : YYSYMBOL_YYUNDEF)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex.  */
static const yytype_int8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40,    41,    42,    43,    44,
      45,    46
};

#if YYDEBUG
/* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_int16 yyrline[] =
{
       0,   163,   163,   163,   164,   165,   167,   169,   179,   195,
     204,   220,   221,   223,   224,   223,   231,   232,   231,   237,
     237,   239,   241,   242,   244,   245,   244,   256,   255,   264,
     266,   267,   269,   270,   272,   280,   288,   296,   316,   336,
     356,   357,   358,   359,   360,   360,   361,   361,   362,   365,
     383,   386,   391,   399,   408,   418,   431,   442,   452,   461,
     469,   475,   486,   487,   489,   490,   492,   508,   527,   534,
     541,   548,   555,   562,   571,   580,   589,   598,   613,   628,
     637,   646,   658,   667,   676,   685,   694,   702,   710,   724,
     725,   730,   724,   735,   735,   737,   739,   744,   737,   749,
     754,   761,   761
};
#endif

/** Accessing symbol of state STATE.  */
#define YY_ACCESSING_SYMBOL(State) YY_CAST (yysymbol_kind_t, yystos[State])

#if YYDEBUG || 0
/* The user-facing name of the symbol whose (internal) number is
   YYSYMBOL.  No bounds checking.  */
static const char *yysymbol_name (yysymbol_kind_t yysymbol) YY_ATTRIBUTE_UNUSED;

/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "\"end of file\"", "error", "\"invalid token\"", "TOKEN_ID",
  "TOKEN_DECIMALCONST", "TOKEN_CHARCONST", "TOKEN_HEXADECIMALCONST",
  "TOKEN_STRINGCONST", "TOKEN_BOOLEANCONST", "TOKEN_PROGRAMCLASS",
  "TOKEN_MAINFUNC", "TOKEN_BREAKSTMT", "TOKEN_CALLOUT", "TOKEN_CLASS",
  "TOKEN_CONTINUESTMT", "TOKEN_VOIDTYPE", "TOKEN_BOOLEANTYPE",
  "TOKEN_INTTYPE", "TOKEN_IFCONDITION", "TOKEN_ELSECONDITION",
  "TOKEN_LOOP", "TOKEN_RETURN", "TOKEN_LP", "TOKEN_RP", "TOKEN_LCB",
  "TOKEN_RCB", "TOKEN_LB", "TOKEN_RB", "TOKEN_SEMICOLON", "TOKEN_COMMA",
  "TOKEN_LOGICOP", "TOKEN_NOTEQUAL", "TOKEN_EQUAL", "TOKEN_AND",
  "TOKEN_OR", "TOKEN_ASSIGNOP", "TOKEN_MINUS_EQUAL", "TOKEN_PLUS_EQUAL",
  "TOKEN_PLUS", "TOKEN_MINUS", "TOKEN_MULTIPLICATION", "TOKEN_DIVISION",
  "TOKEN_MODULO", "TOKEN_GREATER_EQUAL", "TOKEN_LESS_EQUAL",
  "TOKEN_GREATER", "TOKEN_LESS", "$accept", "program", "$@1",
  "decl_fields", "decl_field", "names", "decl_methods", "decl_method",
  "$@2", "$@3", "$@4", "$@5", "method_id", "block", "declare_vars",
  "declare_var", "$@6", "$@7", "ids", "$@8", "type", "statments",
  "statment", "$@9", "$@10", "method_call", "call_params", "method_args",
  "method_arg", "optional_callout_args", "callout_args", "expr", "stmt_if",
  "$@11", "$@12", "$@13", "optional_else", "stmt_for", "$@14", "$@15",
  "$@16", "stmt_return", "callout_arg", YY_NULLPTR
};

static const char *
yysymbol_name (yysymbol_kind_t yysymbol)
{
  return yytname[yysymbol];
}
#endif

#define YYPACT_NINF (-107)

#define yypact_value_is_default(Yyn) \
  ((Yyn) == YYPACT_NINF)

#define YYTABLE_NINF (-20)

#define yytable_value_is_error(Yyn) \
  0

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
static const yytype_int16 yypact[] =
{
       3,     8,    43,    38,  -107,  -107,  -107,     9,     4,  -107,
    -107,  -107,   -23,    35,     9,    12,  -107,  -107,  -107,  -107,
      60,  -107,  -107,     4,    -3,  -107,    44,    45,    53,    52,
      36,    53,    29,  -107,  -107,  -107,  -107,    55,    53,    53,
      53,  -107,   140,    36,    75,    56,    58,   160,    53,    53,
      77,   120,  -107,     0,  -107,    53,    53,    53,    53,    53,
      53,    53,    53,    53,    53,    53,    53,    53,    59,  -107,
    -107,    36,  -107,    62,   332,   180,    66,  -107,   425,   425,
     416,   400,     0,     0,  -107,  -107,  -107,    91,    91,    91,
      91,  -107,    72,    68,  -107,    53,  -107,    42,    80,    72,
      36,  -107,    36,   350,  -107,  -107,   384,    69,  -107,  -107,
      99,    36,  -107,    71,    53,    42,    54,  -107,  -107,  -107,
    -107,    53,  -107,    79,    99,    84,  -107,  -107,    86,  -107,
     112,    36,   368,  -107,    53,    53,    53,    53,    88,    90,
     100,   121,   384,  -107,  -107,  -107,  -107,  -107,  -107,    53,
     200,   219,   238,   257,  -107,  -107,    53,    92,    96,   384,
      33,  -107,  -107,  -107,   384,    53,   123,   106,    53,    53,
      53,   113,   384,  -107,  -107,   276,   295,   314,    72,   109,
      96,  -107,  -107,  -107,  -107,    53,  -107,   116,   384,    72,
    -107,    72,  -107,  -107
};

/* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
   Performed when YYTABLE does not specify something else to do.  Zero
   means the default is an error.  */
static const yytype_int8 yydefact[] =
{
       0,     0,     0,     0,     1,     2,     5,    12,     0,    31,
      30,     4,     0,     0,    12,     0,    19,    20,    13,     6,
       0,     3,    11,     0,     7,    16,     0,     9,     0,     0,
      60,     0,    66,    69,    71,    70,    72,     0,     0,     0,
       0,    68,     0,    60,     0,     0,    59,     0,    51,     0,
       0,     0,    87,    86,     8,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,    61,
      14,     0,    10,     0,    52,     0,    62,    88,    78,    77,
      85,    84,    79,    80,    83,    81,    82,    73,    74,    76,
      75,    17,     0,    58,    49,     0,    67,     0,     0,     0,
      23,    15,     0,    53,   102,    63,   101,    64,    50,    18,
      33,    23,    24,    57,     0,     0,     0,    44,    46,    89,
      95,    99,    48,     0,    33,     0,    41,    42,     0,    22,
       0,     0,    54,    65,     0,     0,     0,     0,     0,     0,
       0,     0,   100,    21,    32,    40,    43,    25,    56,     0,
       0,     0,     0,     0,    45,    47,     0,     0,    29,    55,
       0,    34,    35,    36,    90,     0,     0,     0,     0,     0,
       0,     0,    96,    27,    26,     0,     0,     0,     0,     0,
      29,    37,    38,    39,    91,     0,    28,    94,    97,     0,
      92,     0,    93,    98
};

/* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
    -107,  -107,  -107,  -107,  -107,  -107,   125,  -107,  -107,  -107,
    -107,  -107,   136,   -90,    34,  -107,  -107,  -107,   -34,  -107,
      -6,    23,  -107,  -107,  -107,  -106,  -107,   105,   -58,  -107,
      40,   -28,  -107,  -107,  -107,  -107,  -107,  -107,  -107,  -107,
    -107,  -107,  -107
};

/* YYDEFGOTO[NTERM-NUM].  */
static const yytype_uint8 yydefgoto[] =
{
       0,     2,     6,     7,    11,    12,    13,    14,    26,    92,
      29,    99,    25,   122,   110,   111,   130,   158,   167,   180,
      44,   123,   124,   138,   139,    41,    73,    45,    46,    98,
     105,   106,   126,   140,   171,   187,   190,   127,   141,   179,
     191,   128,   107
};

/* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule whose
   number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_int16 yytable[] =
{
      42,    15,   101,    47,   125,    19,    20,    16,    23,   109,
      51,    52,    53,    93,    17,    24,     1,     3,   125,   -19,
      74,    75,    17,    28,     8,     9,    10,    78,    79,    80,
      81,    82,    83,    84,    85,    86,    87,    88,    89,    90,
      61,    62,    63,     4,   113,    32,    33,    34,    35,   104,
      36,    48,     9,    10,    37,    49,    32,    33,    34,    35,
      21,    36,     5,    27,    38,    37,    30,   103,   168,   169,
     170,    31,    39,   148,    43,    38,    48,    50,    69,    70,
     134,    40,    91,    39,    76,    94,   132,    71,   184,   135,
     136,   137,    40,   142,   112,    97,   100,   102,   115,   192,
     131,   193,   116,   108,   143,   112,   150,   151,   152,   153,
     117,    37,   145,   118,   146,   147,   154,   119,   155,   120,
     121,   159,   156,   100,   157,   166,   173,   165,   164,    59,
      60,    61,    62,    63,   174,   189,   178,   172,   185,    22,
     175,   176,   177,    77,    18,   129,   186,   144,    68,     0,
       0,    55,    56,    57,    58,   133,     0,   188,    59,    60,
      61,    62,    63,    64,    65,    66,    67,    54,     0,     0,
       0,    55,    56,    57,    58,     0,     0,     0,    59,    60,
      61,    62,    63,    64,    65,    66,    67,    72,     0,     0,
       0,    55,    56,    57,    58,     0,     0,     0,    59,    60,
      61,    62,    63,    64,    65,    66,    67,    96,     0,     0,
       0,    55,    56,    57,    58,     0,     0,     0,    59,    60,
      61,    62,    63,    64,    65,    66,    67,   160,     0,     0,
       0,    55,    56,    57,    58,     0,     0,     0,    59,    60,
      61,    62,    63,    64,    65,    66,    67,   161,     0,     0,
      55,    56,    57,    58,     0,     0,     0,    59,    60,    61,
      62,    63,    64,    65,    66,    67,   162,     0,     0,    55,
      56,    57,    58,     0,     0,     0,    59,    60,    61,    62,
      63,    64,    65,    66,    67,   163,     0,     0,    55,    56,
      57,    58,     0,     0,     0,    59,    60,    61,    62,    63,
      64,    65,    66,    67,   181,     0,     0,    55,    56,    57,
      58,     0,     0,     0,    59,    60,    61,    62,    63,    64,
      65,    66,    67,   182,     0,     0,    55,    56,    57,    58,
       0,     0,     0,    59,    60,    61,    62,    63,    64,    65,
      66,    67,   183,     0,     0,    55,    56,    57,    58,     0,
       0,     0,    59,    60,    61,    62,    63,    64,    65,    66,
      67,    95,     0,    55,    56,    57,    58,     0,     0,     0,
      59,    60,    61,    62,    63,    64,    65,    66,    67,   114,
       0,    55,    56,    57,    58,     0,     0,     0,    59,    60,
      61,    62,    63,    64,    65,    66,    67,   149,     0,    55,
      56,    57,    58,     0,     0,     0,    59,    60,    61,    62,
      63,    64,    65,    66,    67,    55,    56,    57,    58,     0,
       0,     0,    59,    60,    61,    62,    63,    64,    65,    66,
      67,    55,    56,    57,     0,     0,     0,     0,    59,    60,
      61,    62,    63,    64,    65,    66,    67,    55,    56,     0,
       0,     0,     0,     0,    59,    60,    61,    62,    63,    64,
      65,    66,    67,    59,    60,    61,    62,    63,    64,    65,
      66,    67
};

static const yytype_int16 yycheck[] =
{
      28,     7,    92,    31,   110,    28,    29,     3,    14,    99,
      38,    39,    40,    71,    10,     3,    13,     9,   124,    22,
      48,    49,    10,    26,    15,    16,    17,    55,    56,    57,
      58,    59,    60,    61,    62,    63,    64,    65,    66,    67,
      40,    41,    42,     0,   102,     3,     4,     5,     6,     7,
       8,    22,    16,    17,    12,    26,     3,     4,     5,     6,
      25,     8,    24,     3,    22,    12,    22,    95,    35,    36,
      37,    26,    30,   131,    22,    22,    22,    22,     3,    23,
      26,    39,    23,    30,     7,    23,   114,    29,   178,    35,
      36,    37,    39,   121,   100,    29,    24,    29,    29,   189,
      29,   191,     3,    23,    25,   111,   134,   135,   136,   137,
      11,    12,    28,    14,    28,     3,    28,    18,    28,    20,
      21,   149,    22,    24,     3,    29,     3,    35,   156,    38,
      39,    40,    41,    42,    28,    19,    23,   165,    29,    14,
     168,   169,   170,    23,     8,   111,   180,   124,    43,    -1,
      -1,    31,    32,    33,    34,   115,    -1,   185,    38,    39,
      40,    41,    42,    43,    44,    45,    46,    27,    -1,    -1,
      -1,    31,    32,    33,    34,    -1,    -1,    -1,    38,    39,
      40,    41,    42,    43,    44,    45,    46,    27,    -1,    -1,
      -1,    31,    32,    33,    34,    -1,    -1,    -1,    38,    39,
      40,    41,    42,    43,    44,    45,    46,    27,    -1,    -1,
      -1,    31,    32,    33,    34,    -1,    -1,    -1,    38,    39,
      40,    41,    42,    43,    44,    45,    46,    27,    -1,    -1,
      -1,    31,    32,    33,    34,    -1,    -1,    -1,    38,    39,
      40,    41,    42,    43,    44,    45,    46,    28,    -1,    -1,
      31,    32,    33,    34,    -1,    -1,    -1,    38,    39,    40,
      41,    42,    43,    44,    45,    46,    28,    -1,    -1,    31,
      32,    33,    34,    -1,    -1,    -1,    38,    39,    40,    41,
      42,    43,    44,    45,    46,    28,    -1,    -1,    31,    32,
      33,    34,    -1,    -1,    -1,    38,    39,    40,    41,    42,
      43,    44,    45,    46,    28,    -1,    -1,    31,    32,    33,
      34,    -1,    -1,    -1,    38,    39,    40,    41,    42,    43,
      44,    45,    46,    28,    -1,    -1,    31,    32,    33,    34,
      -1,    -1,    -1,    38,    39,    40,    41,    42,    43,    44,
      45,    46,    28,    -1,    -1,    31,    32,    33,    34,    -1,
      -1,    -1,    38,    39,    40,    41,    42,    43,    44,    45,
      46,    29,    -1,    31,    32,    33,    34,    -1,    -1,    -1,
      38,    39,    40,    41,    42,    43,    44,    45,    46,    29,
      -1,    31,    32,    33,    34,    -1,    -1,    -1,    38,    39,
      40,    41,    42,    43,    44,    45,    46,    29,    -1,    31,
      32,    33,    34,    -1,    -1,    -1,    38,    39,    40,    41,
      42,    43,    44,    45,    46,    31,    32,    33,    34,    -1,
      -1,    -1,    38,    39,    40,    41,    42,    43,    44,    45,
      46,    31,    32,    33,    -1,    -1,    -1,    -1,    38,    39,
      40,    41,    42,    43,    44,    45,    46,    31,    32,    -1,
      -1,    -1,    -1,    -1,    38,    39,    40,    41,    42,    43,
      44,    45,    46,    38,    39,    40,    41,    42,    43,    44,
      45,    46
};

/* YYSTOS[STATE-NUM] -- The symbol kind of the accessing symbol of
   state STATE-NUM.  */
static const yytype_int8 yystos[] =
{
       0,    13,    48,     9,     0,    24,    49,    50,    15,    16,
      17,    51,    52,    53,    54,    67,     3,    10,    59,    28,
      29,    25,    53,    67,     3,    59,    55,     3,    26,    57,
      22,    26,     3,     4,     5,     6,     8,    12,    22,    30,
      39,    72,    78,    22,    67,    74,    75,    78,    22,    26,
      22,    78,    78,    78,    27,    31,    32,    33,    34,    38,
      39,    40,    41,    42,    43,    44,    45,    46,    74,     3,
      23,    29,    27,    73,    78,    78,     7,    23,    78,    78,
      78,    78,    78,    78,    78,    78,    78,    78,    78,    78,
      78,    23,    56,    75,    23,    29,    27,    29,    76,    58,
      24,    60,    29,    78,     7,    77,    78,    89,    23,    60,
      61,    62,    67,    75,    29,    29,     3,    11,    14,    18,
      20,    21,    60,    68,    69,    72,    79,    84,    88,    61,
      63,    29,    78,    77,    26,    35,    36,    37,    70,    71,
      80,    85,    78,    25,    68,    28,    28,     3,    75,    29,
      78,    78,    78,    78,    28,    28,    22,     3,    64,    78,
      27,    28,    28,    28,    78,    35,    29,    65,    35,    36,
      37,    81,    78,     3,    28,    78,    78,    78,    23,    86,
      66,    28,    28,    28,    60,    29,    65,    82,    78,    19,
      83,    87,    60,    60
};

/* YYR1[RULE-NUM] -- Symbol kind of the left-hand side of rule RULE-NUM.  */
static const yytype_int8 yyr1[] =
{
       0,    47,    49,    48,    50,    50,    51,    52,    52,    52,
      52,    53,    53,    55,    56,    54,    57,    58,    54,    59,
      59,    60,    61,    61,    63,    64,    62,    66,    65,    65,
      67,    67,    68,    68,    69,    69,    69,    69,    69,    69,
      69,    69,    69,    69,    70,    69,    71,    69,    69,    72,
      72,    73,    73,    73,    73,    73,    74,    74,    74,    74,
      74,    75,    76,    76,    77,    77,    78,    78,    78,    78,
      78,    78,    78,    78,    78,    78,    78,    78,    78,    78,
      78,    78,    78,    78,    78,    78,    78,    78,    78,    80,
      81,    82,    79,    83,    83,    85,    86,    87,    84,    88,
      88,    89,    89
};

/* YYR2[RULE-NUM] -- Number of symbols on the right-hand side of rule RULE-NUM.  */
static const yytype_int8 yyr2[] =
{
       0,     2,     0,     7,     2,     0,     2,     2,     5,     3,
       6,     2,     0,     0,     0,     8,     0,     0,     8,     1,
       1,     4,     2,     0,     0,     0,     6,     0,     4,     0,
       1,     1,     2,     0,     4,     4,     4,     7,     7,     7,
       2,     1,     1,     2,     0,     3,     0,     3,     1,     4,
       5,     0,     1,     3,     5,     7,     7,     5,     3,     1,
       0,     2,     0,     2,     1,     3,     1,     4,     1,     1,
       1,     1,     1,     3,     3,     3,     3,     3,     3,     3,
       3,     3,     3,     3,     3,     3,     2,     2,     3,     0,
       0,     0,     9,     2,     0,     0,     0,     0,    10,     1,
       2,     1,     1
};


enum { YYENOMEM = -2 };

#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab
#define YYNOMEM         goto yyexhaustedlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                    \
  do                                                              \
    if (yychar == YYEMPTY)                                        \
      {                                                           \
        yychar = (Token);                                         \
        yylval = (Value);                                         \
        YYPOPSTACK (yylen);                                       \
        yystate = *yyssp;                                         \
        goto yybackup;                                            \
      }                                                           \
    else                                                          \
      {                                                           \
        yyerror (YY_("syntax error: cannot back up")); \
        YYERROR;                                                  \
      }                                                           \
  while (0)

/* Backward compatibility with an undocumented macro.
   Use YYerror or YYUNDEF. */
#define YYERRCODE YYUNDEF


/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)




# define YY_SYMBOL_PRINT(Title, Kind, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Kind, Value); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*-----------------------------------.
| Print this symbol's value on YYO.  |
`-----------------------------------*/

static void
yy_symbol_value_print (FILE *yyo,
                       yysymbol_kind_t yykind, YYSTYPE const * const yyvaluep)
{
  FILE *yyoutput = yyo;
  YY_USE (yyoutput);
  if (!yyvaluep)
    return;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YY_USE (yykind);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/*---------------------------.
| Print this symbol on YYO.  |
`---------------------------*/

static void
yy_symbol_print (FILE *yyo,
                 yysymbol_kind_t yykind, YYSTYPE const * const yyvaluep)
{
  YYFPRINTF (yyo, "%s %s (",
             yykind < YYNTOKENS ? "token" : "nterm", yysymbol_name (yykind));

  yy_symbol_value_print (yyo, yykind, yyvaluep);
  YYFPRINTF (yyo, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yy_state_t *yybottom, yy_state_t *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yy_state_t *yyssp, YYSTYPE *yyvsp,
                 int yyrule)
{
  int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %d):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       YY_ACCESSING_SYMBOL (+yyssp[yyi + 1 - yynrhs]),
                       &yyvsp[(yyi + 1) - (yynrhs)]);
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, Rule); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args) ((void) 0)
# define YY_SYMBOL_PRINT(Title, Kind, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif






/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg,
            yysymbol_kind_t yykind, YYSTYPE *yyvaluep)
{
  YY_USE (yyvaluep);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yykind, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YY_USE (yykind);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/* Lookahead token kind.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Number of syntax errors so far.  */
int yynerrs;




/*----------.
| yyparse.  |
`----------*/

int
yyparse (void)
{
    yy_state_fast_t yystate = 0;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus = 0;

    /* Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* Their size.  */
    YYPTRDIFF_T yystacksize = YYINITDEPTH;

    /* The state stack: array, bottom, top.  */
    yy_state_t yyssa[YYINITDEPTH];
    yy_state_t *yyss = yyssa;
    yy_state_t *yyssp = yyss;

    /* The semantic value stack: array, bottom, top.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs = yyvsa;
    YYSTYPE *yyvsp = yyvs;

  int yyn;
  /* The return value of yyparse.  */
  int yyresult;
  /* Lookahead symbol kind.  */
  yysymbol_kind_t yytoken = YYSYMBOL_YYEMPTY;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;



#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yychar = YYEMPTY; /* Cause a token to be read.  */

  goto yysetstate;


/*------------------------------------------------------------.
| yynewstate -- push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;


/*--------------------------------------------------------------------.
| yysetstate -- set current state (the top of the stack) to yystate.  |
`--------------------------------------------------------------------*/
yysetstate:
  YYDPRINTF ((stderr, "Entering state %d\n", yystate));
  YY_ASSERT (0 <= yystate && yystate < YYNSTATES);
  YY_IGNORE_USELESS_CAST_BEGIN
  *yyssp = YY_CAST (yy_state_t, yystate);
  YY_IGNORE_USELESS_CAST_END
  YY_STACK_PRINT (yyss, yyssp);

  if (yyss + yystacksize - 1 <= yyssp)
#if !defined yyoverflow && !defined YYSTACK_RELOCATE
    YYNOMEM;
#else
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYPTRDIFF_T yysize = yyssp - yyss + 1;

# if defined yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        yy_state_t *yyss1 = yyss;
        YYSTYPE *yyvs1 = yyvs;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * YYSIZEOF (*yyssp),
                    &yyvs1, yysize * YYSIZEOF (*yyvsp),
                    &yystacksize);
        yyss = yyss1;
        yyvs = yyvs1;
      }
# else /* defined YYSTACK_RELOCATE */
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        YYNOMEM;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yy_state_t *yyss1 = yyss;
        union yyalloc *yyptr =
          YY_CAST (union yyalloc *,
                   YYSTACK_ALLOC (YY_CAST (YYSIZE_T, YYSTACK_BYTES (yystacksize))));
        if (! yyptr)
          YYNOMEM;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
#  undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YY_IGNORE_USELESS_CAST_BEGIN
      YYDPRINTF ((stderr, "Stack size increased to %ld\n",
                  YY_CAST (long, yystacksize)));
      YY_IGNORE_USELESS_CAST_END

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }
#endif /* !defined yyoverflow && !defined YYSTACK_RELOCATE */


  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;


/*-----------.
| yybackup.  |
`-----------*/
yybackup:
  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either empty, or end-of-input, or a valid lookahead.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token\n"));
      yychar = yylex ();
    }

  if (yychar <= YYEOF)
    {
      yychar = YYEOF;
      yytoken = YYSYMBOL_YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else if (yychar == YYerror)
    {
      /* The scanner already issued an error message, process directly
         to error recovery.  But do not keep the error token as
         lookahead, it is too special and may lead us to an endless
         loop in error recovery. */
      yychar = YYUNDEF;
      yytoken = YYSYMBOL_YYerror;
      goto yyerrlab1;
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);
  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  /* Discard the shifted token.  */
  yychar = YYEMPTY;
  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
  case 2: /* $@1: %empty  */
#line 163 "parser.y"
                                                   {currentScope += " program"; }
#line 1421 "parser.tab.c"
    break;

  case 3: /* program: TOKEN_CLASS TOKEN_PROGRAMCLASS TOKEN_LCB $@1 decl_fields decl_methods TOKEN_RCB  */
#line 163 "parser.y"
                                                                                                                       {currentScope.erase(currentScope.size()-(strlen("program")+1),strlen("program")+1);}
#line 1427 "parser.tab.c"
    break;

  case 7: /* names: type TOKEN_ID  */
#line 170 "parser.y"
        {		
		struct Symbol* scalar_symbol=getSymbol((yyvsp[0].str_val),currentScope,false);		
		if(scalar_symbol == NULL){ //add symbol to table		
		pushSymbol((yyvsp[0].str_val),currentScope,getNewRegister('s'),(yyvsp[-1].str_val),false,0);			
		}else{
			yyerror("variable was defined before!");
		}
		field_type = (yyvsp[-1].str_val);			
	}
#line 1441 "parser.tab.c"
    break;

  case 8: /* names: type TOKEN_ID TOKEN_LB expr TOKEN_RB  */
#line 180 "parser.y"
                {
			if(((yyvsp[-1].Expr))->expr_type !="int"){
				yyerror("Error: size of array should be integer!!");
			}else if(((yyvsp[-1].Expr))->expr_val_int <0){
				yyerror("Error: size of array should be positive number!!");
			}else{
				struct Symbol* array_symbol=getSymbol((yyvsp[-3].str_val),currentScope,true);
				if(array_symbol == NULL){ //add symbol to table
				pushSymbol((yyvsp[-3].str_val),currentScope,getNewRegister('s'),(yyvsp[-4].str_val),true,((yyvsp[-1].Expr))->expr_val_int);	
				}else{
					yyerror("variable was defined before!");
				}
			}
			field_type = (yyvsp[-4].str_val);
		}
#line 1461 "parser.tab.c"
    break;

  case 9: /* names: names TOKEN_COMMA TOKEN_ID  */
#line 196 "parser.y"
        {
		struct Symbol* scalar_symbol=getSymbol((yyvsp[0].str_val),currentScope,false);
		if(scalar_symbol == NULL){ //add symbol to table
		pushSymbol((yyvsp[0].str_val),currentScope,getNewRegister('s'),field_type,false,0);	
		}else{
			yyerror("variable was defined before!");
		}
	}
#line 1474 "parser.tab.c"
    break;

  case 10: /* names: names TOKEN_COMMA TOKEN_ID TOKEN_LB expr TOKEN_RB  */
#line 205 "parser.y"
        {
		if(((yyvsp[-1].Expr))->expr_type !="int"){
			yyerror("Error: size of array should be integer!!");
		}else if(((yyvsp[-1].Expr))->expr_val_int <0){
			yyerror("Error: size of array should be positive number!!");
		}else{
			struct Symbol* array_symbol=getSymbol((yyvsp[-3].str_val),currentScope,true);
			if(array_symbol == NULL){ //add symbol to table
			pushSymbol((yyvsp[-3].str_val),currentScope,getNewRegister('s'),field_type,true,((yyvsp[-1].Expr))->expr_val_int);	
			}else{
				yyerror("variable was defined before!");
			}
		}
	}
#line 1493 "parser.tab.c"
    break;

  case 13: /* $@2: %empty  */
#line 223 "parser.y"
                                       {currentScope =currentScope+" "+((yyvsp[0].str_val));}
#line 1499 "parser.tab.c"
    break;

  case 14: /* $@3: %empty  */
#line 224 "parser.y"
                        {                
				current_func=(yyvsp[-4].str_val);
				if(strcmp((yyvsp[-4].str_val),"main")==0 && ((yyvsp[-1].Args))->num_args !=0){
					yyerror("main functioin cannot have arguments!");
				}
				pushFunction((yyvsp[-4].str_val),"void",((yyvsp[-1].Args))->num_args,((yyvsp[-1].Args))->args_types);
			}
#line 1511 "parser.tab.c"
    break;

  case 15: /* decl_method: TOKEN_VOIDTYPE method_id $@2 TOKEN_LP method_args TOKEN_RP $@3 block  */
#line 230 "parser.y"
                                { current_func ="" ;currentScope.erase(currentScope.size()-(string((yyvsp[-6].str_val)).size()+1),string((yyvsp[-6].str_val)).size()+1);}
#line 1517 "parser.tab.c"
    break;

  case 16: /* $@4: %empty  */
#line 231 "parser.y"
                                        {currentScope =currentScope+" "+((yyvsp[0].str_val));}
#line 1523 "parser.tab.c"
    break;

  case 17: /* $@5: %empty  */
#line 232 "parser.y"
                        {
				current_func=(yyvsp[-4].str_val);							
				pushFunction((yyvsp[-4].str_val),(yyvsp[-5].str_val),((yyvsp[-1].Args))->num_args,((yyvsp[-1].Args))->args_types);				
			}
#line 1532 "parser.tab.c"
    break;

  case 18: /* decl_method: type method_id $@4 TOKEN_LP method_args TOKEN_RP $@5 block  */
#line 235 "parser.y"
                                { current_func ="" ;currentScope.erase(currentScope.size()-(string((yyvsp[-6].str_val)).size()+1),string((yyvsp[-6].str_val)).size()+1);}
#line 1538 "parser.tab.c"
    break;

  case 19: /* method_id: TOKEN_ID  */
#line 237 "parser.y"
                      {(yyval.str_val)=(yyvsp[0].str_val);}
#line 1544 "parser.tab.c"
    break;

  case 20: /* method_id: TOKEN_MAINFUNC  */
#line 237 "parser.y"
                                               {(yyval.str_val)=strdup("main");}
#line 1550 "parser.tab.c"
    break;

  case 24: /* $@6: %empty  */
#line 244 "parser.y"
                   {var_type =(yyvsp[0].str_val);}
#line 1556 "parser.tab.c"
    break;

  case 25: /* $@7: %empty  */
#line 245 "parser.y"
        {
		struct Symbol* scalar_symbol=getSymbol((yyvsp[0].str_val),currentScope,false);
		if(scalar_symbol == NULL){ //add symbol to table		
		pushSymbol((yyvsp[0].str_val),currentScope,getNewRegister('s'),(yyvsp[-2].str_val),false,0);	
		}else{
			yyerror("variable was defined before");
		}			
	}
#line 1569 "parser.tab.c"
    break;

  case 27: /* $@8: %empty  */
#line 256 "parser.y"
         {
		struct Symbol* scalar_symbol=getSymbol((yyvsp[0].str_val),currentScope,false);
		if(scalar_symbol == NULL){ //add symbol to table
		pushSymbol((yyvsp[0].str_val),currentScope,getNewRegister('s'),var_type,false,0);	
		}else{
			yyerror("variable was defined before");
		}			 
	 }
#line 1582 "parser.tab.c"
    break;

  case 30: /* type: TOKEN_INTTYPE  */
#line 266 "parser.y"
                     {(yyval.str_val) = strdup("int");}
#line 1588 "parser.tab.c"
    break;

  case 31: /* type: TOKEN_BOOLEANTYPE  */
#line 267 "parser.y"
                                    {(yyval.str_val) = strdup("boolean");}
#line 1594 "parser.tab.c"
    break;

  case 34: /* statment: TOKEN_ID TOKEN_ASSIGNOP expr TOKEN_SEMICOLON  */
#line 273 "parser.y"
                {
			struct Symbol* scalar_symbol=getSymbol((yyvsp[-3].str_val),currentScope,false);
			if(scalar_symbol == NULL) yyerror("Error: variable was not defined yet!");	            
			if(scalar_symbol->symbol_type != ((yyvsp[-1].Expr))->expr_type){
				yyerror("Operands of = Operation should have same type");
			}			
		}
#line 1606 "parser.tab.c"
    break;

  case 35: /* statment: TOKEN_ID TOKEN_MINUS_EQUAL expr TOKEN_SEMICOLON  */
#line 281 "parser.y"
                {
			struct Symbol* scalar_symbol=getSymbol((yyvsp[-3].str_val),currentScope,false);
			if(scalar_symbol == NULL) yyerror("Error: variable was not defined yet!");	
			if((scalar_symbol->symbol_type != "int") || (((yyvsp[-1].Expr))->expr_type != "int") ){
				yyerror("Operands of -= Operation should have INTEGER type");
			}			
		}
#line 1618 "parser.tab.c"
    break;

  case 36: /* statment: TOKEN_ID TOKEN_PLUS_EQUAL expr TOKEN_SEMICOLON  */
#line 289 "parser.y"
                {            
			struct Symbol* scalar_symbol=getSymbol((yyvsp[-3].str_val),currentScope,false);
			if(scalar_symbol == NULL)yyerror("Error: variable was not defined yet!");
			if((scalar_symbol->symbol_type != "int") || (((yyvsp[-1].Expr))->expr_type != "int") ){
				yyerror("Operands of += Operation should have same type");
			}	
		}
#line 1630 "parser.tab.c"
    break;

  case 37: /* statment: TOKEN_ID TOKEN_LB expr TOKEN_RB TOKEN_ASSIGNOP expr TOKEN_SEMICOLON  */
#line 297 "parser.y"
                {                        
			if(((yyvsp[-4].Expr))->expr_type !="int"){
				yyerror("Error: size of array should be integer!");
			}else if(((yyvsp[-4].Expr))->expr_val_int <0){
				yyerror("Error: size of array can not be negative number!");
			}else{
				struct Symbol* array_symbol=getSymbol((yyvsp[-6].str_val),currentScope,true);
				if(array_symbol == NULL){ 
				yyerror("Error: array was not defined yet!");
				}else{
					if(((yyvsp[-4].Expr))->expr_val_int > array_symbol->array_size){
					yyerror("Error: array index should be in range of array size!!");		
					}	
					if(array_symbol->symbol_type != ((yyvsp[-4].Expr))->expr_type){
					yyerror("Operands of = Operation should have same type");
					}				
				}
			}
		}
#line 1654 "parser.tab.c"
    break;

  case 38: /* statment: TOKEN_ID TOKEN_LB expr TOKEN_RB TOKEN_MINUS_EQUAL expr TOKEN_SEMICOLON  */
#line 317 "parser.y"
                {
			if(((yyvsp[-4].Expr))->expr_type !="int"){
				yyerror("Error: size of array should be integer!!");
			}else if(((yyvsp[-4].Expr))->expr_val_int <0){
				yyerror("Error: size of array should be positive number!!");
			}else{
				struct Symbol* array_symbol=getSymbol((yyvsp[-6].str_val),currentScope,true);
				if(array_symbol == NULL){ 
				yyerror("Error: array was not defined yet!");
				}else{
					if(((yyvsp[-4].Expr))->expr_val_int > array_symbol->array_size){
					yyerror("Error: array index should be in range of array size!!");		
					}			
					if(( array_symbol->symbol_type != "int") || (((yyvsp[-4].Expr))->expr_type != "int") ){
						yyerror("Operands of -= Operation should have INTEGER type");
					}				
				}
			}
		}
#line 1678 "parser.tab.c"
    break;

  case 39: /* statment: TOKEN_ID TOKEN_LB expr TOKEN_RB TOKEN_PLUS_EQUAL expr TOKEN_SEMICOLON  */
#line 337 "parser.y"
                {
			if(((yyvsp[-4].Expr))->expr_type !="int"){
				yyerror("Error: size of array should be integer!!");
			}else if(((yyvsp[-4].Expr))->expr_val_int <0){
				yyerror("Error: size of array should be positive number!!");
			}else{
				struct Symbol* array_symbol=getSymbol((yyvsp[-6].str_val),currentScope,true);
				if(array_symbol == NULL){ 
				yyerror("Error: array was not defined yet!");
				}else{
					if(((yyvsp[-4].Expr))->expr_val_int > array_symbol->array_size){
					yyerror("Error: array index should be in range of array size!!");		
					}
					if(( array_symbol->symbol_type != "int") || (((yyvsp[-4].Expr))->expr_type != "int") ){
						yyerror("Operands of += Operation should have INTEGER type");
					}							
				}
			}
		}
#line 1702 "parser.tab.c"
    break;

  case 44: /* $@9: %empty  */
#line 360 "parser.y"
                                  {if(currentScope.find("for") == string::npos) yyerror("Error:Can not use BREAK out of FOR loop!");}
#line 1708 "parser.tab.c"
    break;

  case 46: /* $@10: %empty  */
#line 361 "parser.y"
                                     {if(currentScope.find("for") == string::npos) yyerror("Error:Can not use CONTINUE out of FOR loop!");}
#line 1714 "parser.tab.c"
    break;

  case 49: /* method_call: TOKEN_ID TOKEN_LP call_params TOKEN_RP  */
#line 366 "parser.y"
                {
			struct Function *func = getFunction((yyvsp[-3].str_val));
			if(func==NULL) yyerror(strdup("cannot use undefined function"));				
			if(func->num_args != ((yyvsp[-1].Args))->num_args) yyerror("Error: number of used arguments does not match with defined function.\nfunction should have *"+ convertToString(func->num_args)+" arguments*.\n");
			sprintf((yyval.str_val), "%s", func->return_type.c_str()); //!SAVE RETURN TYPE				
			for(int i=0;i<func->num_args;i++){
				if(func->args_types[i] != ((yyvsp[-1].Args))->args_types[i]){
					yyerror("type of argument with number "+ convertToString(i)+" does not match with defined function!");
				}
			}	
		
         if(func==NULL) yyerror(strdup("undefined function"));
         else {
           if(func->num_args != ((yyvsp[-1].Args))->num_args) yyerror(strdup("the number of arguments does not match"));
           else{}
         }			
		}
#line 1736 "parser.tab.c"
    break;

  case 51: /* call_params: %empty  */
#line 386 "parser.y"
                {
			struct ArgsStruct* pnt = new ArgsStruct();
			pnt->num_args = 0;						
			(yyval.Args) = pnt;		
		}
#line 1746 "parser.tab.c"
    break;

  case 52: /* call_params: expr  */
#line 392 "parser.y"
                {
			struct ArgsStruct* pnt = new ArgsStruct();
			pnt->num_args = 1;
			pnt->args_types = new string[1];
			pnt->args_types[0] = ((yyvsp[0].Expr))->expr_type;							
			(yyval.Args) = pnt;	
		}
#line 1758 "parser.tab.c"
    break;

  case 53: /* call_params: expr TOKEN_COMMA expr  */
#line 400 "parser.y"
                {
			struct ArgsStruct* pnt = new ArgsStruct();
			pnt->num_args = 2;
			pnt->args_types = new string[2];
			pnt->args_types[0] = ((yyvsp[-2].Expr))->expr_type;
			pnt->args_types[1] = ((yyvsp[0].Expr))->expr_type;					
			(yyval.Args) = pnt;	
		}
#line 1771 "parser.tab.c"
    break;

  case 54: /* call_params: expr TOKEN_COMMA expr TOKEN_COMMA expr  */
#line 409 "parser.y"
                {
			struct ArgsStruct* pnt = new ArgsStruct();
			pnt->num_args = 3;
			pnt->args_types = new string[3];
			pnt->args_types[0] = ((yyvsp[-4].Expr))->expr_type;
			pnt->args_types[1] = ((yyvsp[-2].Expr))->expr_type;
			pnt->args_types[2] = ((yyvsp[0].Expr))->expr_type;			
			(yyval.Args) = pnt;	
		}
#line 1785 "parser.tab.c"
    break;

  case 55: /* call_params: expr TOKEN_COMMA expr TOKEN_COMMA expr TOKEN_COMMA expr  */
#line 419 "parser.y"
                {
			struct ArgsStruct* pnt = new ArgsStruct();
			pnt->num_args = 4;
			pnt->args_types = new string[4];
			pnt->args_types[0] = ((yyvsp[-6].Expr))->expr_type;
			pnt->args_types[1] = ((yyvsp[-4].Expr))->expr_type;
			pnt->args_types[2] = ((yyvsp[-2].Expr))->expr_type;
			pnt->args_types[3] = ((yyvsp[0].Expr))->expr_type;
			(yyval.Args) = pnt;			
		}
#line 1800 "parser.tab.c"
    break;

  case 56: /* method_args: method_arg TOKEN_COMMA method_arg TOKEN_COMMA method_arg TOKEN_COMMA method_arg  */
#line 432 "parser.y"
                {
			struct ArgsStruct* pnt = new ArgsStruct();
			pnt->num_args = 4;
			pnt->args_types = new string[4];
			pnt->args_types[0] = (yyvsp[-6].str_val);
			pnt->args_types[1] = (yyvsp[-4].str_val);
			pnt->args_types[2] = (yyvsp[-2].str_val);
			pnt->args_types[3] = (yyvsp[0].str_val);
			(yyval.Args) = pnt;			
		}
#line 1815 "parser.tab.c"
    break;

  case 57: /* method_args: method_arg TOKEN_COMMA method_arg TOKEN_COMMA method_arg  */
#line 443 "parser.y"
                {
			struct ArgsStruct* pnt = new ArgsStruct();
			pnt->num_args = 3;
			pnt->args_types = new string[3];
			pnt->args_types[0] = (yyvsp[-4].str_val);
			pnt->args_types[1] = (yyvsp[-2].str_val);
			pnt->args_types[2] = (yyvsp[0].str_val);			
			(yyval.Args) = pnt;	
		}
#line 1829 "parser.tab.c"
    break;

  case 58: /* method_args: method_arg TOKEN_COMMA method_arg  */
#line 453 "parser.y"
                {
			struct ArgsStruct* pnt = new ArgsStruct();
			pnt->num_args = 2;
			pnt->args_types = new string[2];
			pnt->args_types[0] = (yyvsp[-2].str_val);
			pnt->args_types[1] = (yyvsp[0].str_val);
			(yyval.Args) = pnt;	
		}
#line 1842 "parser.tab.c"
    break;

  case 59: /* method_args: method_arg  */
#line 462 "parser.y"
                {
			struct ArgsStruct* pnt = new ArgsStruct();
			pnt->num_args = 1;
			pnt->args_types = new string[1];
			pnt->args_types[0] = (yyvsp[0].str_val);
			(yyval.Args) = pnt;	
		}
#line 1854 "parser.tab.c"
    break;

  case 60: /* method_args: %empty  */
#line 469 "parser.y"
                 {
			struct ArgsStruct* pnt = new ArgsStruct();
			pnt->num_args = 0;						
			(yyval.Args) = pnt;			
		}
#line 1864 "parser.tab.c"
    break;

  case 61: /* method_arg: type TOKEN_ID  */
#line 476 "parser.y"
                        {
				(yyval.str_val) = (yyvsp[-1].str_val);
				//!check				
				struct Symbol* scalar_symbol=getSymbol((yyvsp[0].str_val),currentScope,false);
				if(scalar_symbol == NULL){ //add symbol to table
				pushSymbol((yyvsp[0].str_val),currentScope,getNewRegister('s'),(yyvsp[-1].str_val),false,0);	
				}else{
					yyerror("variable was defined before");
				}				
			}
#line 1879 "parser.tab.c"
    break;

  case 66: /* expr: TOKEN_ID  */
#line 493 "parser.y"
                {			
			struct Symbol* scalar_symbol = getSymbol((yyvsp[0].str_val),currentScope,false);
			if(scalar_symbol == NULL) yyerror("Error: variable was not defined yet!");			
			struct ExprStruct* pnt = new ExprStruct();
			pnt->expr_type = scalar_symbol->symbol_type;
            //!CHECK?
            if(pnt->expr_type == "int"){
			pnt->expr_val_int = 0;
		    }else if(pnt->expr_type == "boolean"){
		    	pnt->expr_val_bool = false;
		    }else if(pnt->expr_type == "char"){
		    	// pnt->expr_val_char = '';
		    }
			(yyval.Expr) = pnt;			
		}
#line 1899 "parser.tab.c"
    break;

  case 67: /* expr: TOKEN_ID TOKEN_LB expr TOKEN_RB  */
#line 509 "parser.y"
                {
			if(((yyvsp[-1].Expr))->expr_type !="int"){
				yyerror("Error: size of array should be integer!!");
			}else if(((yyvsp[-1].Expr))->expr_val_int <0){
				yyerror("Error: size of array should be positive number!!");
			}else{
				struct Symbol* array_symbol=getSymbol((yyvsp[-3].str_val),currentScope,true);								
				if(array_symbol == NULL) yyerror("Error: array was not defined yet!");
				else{
					if(((yyvsp[-1].Expr))->expr_val_int > array_symbol->array_size){
					yyerror("Error: array index should be in range of array size!!");				
					}
				    struct ExprStruct* pnt = new ExprStruct();
					pnt->expr_type = array_symbol->symbol_type;
					(yyval.Expr) = pnt;
				}
			}
		}
#line 1922 "parser.tab.c"
    break;

  case 68: /* expr: method_call  */
#line 528 "parser.y"
    {
        if(strcmp(((yyvsp[0].str_val)),"void")==0) yyerror("Error: cannot use void function in EXPRESSIONS");
        struct ExprStruct* pnt = new ExprStruct();
		pnt->expr_type = strdup((yyvsp[0].str_val));
        (yyval.Expr) = pnt;
    }
#line 1933 "parser.tab.c"
    break;

  case 69: /* expr: TOKEN_DECIMALCONST  */
#line 535 "parser.y"
        {		
		struct ExprStruct* pnt = new ExprStruct();
		pnt->expr_type ="int";
		pnt->expr_val_int = (yyvsp[0].int_val);		
		(yyval.Expr) = pnt;					
	}
#line 1944 "parser.tab.c"
    break;

  case 70: /* expr: TOKEN_HEXADECIMALCONST  */
#line 542 "parser.y"
        {	
		struct ExprStruct* pnt = new ExprStruct();
		pnt->expr_type ="int";
		pnt->expr_val_int = (yyvsp[0].int_val);
		(yyval.Expr) = pnt;
	}
#line 1955 "parser.tab.c"
    break;

  case 71: /* expr: TOKEN_CHARCONST  */
#line 549 "parser.y"
        {
		struct ExprStruct* pnt= new ExprStruct();
		pnt->expr_type ="char";
		pnt->expr_val_char = (yyvsp[0].char_val);
		(yyval.Expr) = pnt;
	}
#line 1966 "parser.tab.c"
    break;

  case 72: /* expr: TOKEN_BOOLEANCONST  */
#line 556 "parser.y"
        {			
		struct ExprStruct* pnt = new ExprStruct();
		pnt->expr_type ="boolean";
		pnt->expr_val_bool = (yyvsp[0].bool_val);
		(yyval.Expr) = pnt;
	}
#line 1977 "parser.tab.c"
    break;

  case 73: /* expr: expr TOKEN_GREATER_EQUAL expr  */
#line 563 "parser.y"
        {
		if(((yyvsp[-2].Expr))->expr_type !="int" || ((yyvsp[0].Expr))->expr_type !="int")
          yyerror("Operands of >= Operation should have int type");
		struct ExprStruct* pnt = new ExprStruct();
		pnt->expr_type ="boolean";
		pnt->expr_val_bool = ((yyvsp[-2].Expr))->expr_val_int >=((yyvsp[0].Expr))->expr_val_int?  true : false;		
		(yyval.Expr) = pnt;					
    }
#line 1990 "parser.tab.c"
    break;

  case 74: /* expr: expr TOKEN_LESS_EQUAL expr  */
#line 572 "parser.y"
        { 
		if(((yyvsp[-2].Expr))->expr_type !="int" || ((yyvsp[0].Expr))->expr_type !="int")
          yyerror("Operands of <= Operation should have int type");
		struct ExprStruct* pnt = new ExprStruct();
		pnt->expr_type ="boolean";
		pnt->expr_val_bool = ((yyvsp[-2].Expr))->expr_val_int <=((yyvsp[0].Expr))->expr_val_int?  true : false;		
		(yyval.Expr) = pnt;	   	
    }
#line 2003 "parser.tab.c"
    break;

  case 75: /* expr: expr TOKEN_LESS expr  */
#line 581 "parser.y"
        { 
		if(((yyvsp[-2].Expr))->expr_type !="int" || ((yyvsp[0].Expr))->expr_type !="int")
        yyerror("Operands of < Operation should have int type");
		struct ExprStruct* pnt = new ExprStruct();
		pnt->expr_type ="boolean";
		pnt->expr_val_bool = ((yyvsp[-2].Expr))->expr_val_int < ((yyvsp[0].Expr))->expr_val_int ? true : false;		
	   	(yyval.Expr) = pnt;	
    }
#line 2016 "parser.tab.c"
    break;

  case 76: /* expr: expr TOKEN_GREATER expr  */
#line 590 "parser.y"
        { 
		if(((yyvsp[-2].Expr))->expr_type !="int" || ((yyvsp[0].Expr))->expr_type !="int")
          yyerror("Operands of > Operation should have int type");
		struct ExprStruct* pnt = new ExprStruct();
		pnt->expr_type ="boolean";
		pnt->expr_val_bool = ((yyvsp[-2].Expr))->expr_val_int > ((yyvsp[0].Expr))->expr_val_int ? true : false;		
		(yyval.Expr) = pnt;		
    }
#line 2029 "parser.tab.c"
    break;

  case 77: /* expr: expr TOKEN_EQUAL expr  */
#line 599 "parser.y"
                {
		struct ExprStruct* pnt = new ExprStruct();
		if((((yyvsp[-2].Expr))->expr_type =="int" && ((yyvsp[0].Expr))->expr_type =="int")){
			pnt->expr_type ="boolean";
			pnt->expr_val_bool = ((yyvsp[-2].Expr))->expr_val_int == ((yyvsp[0].Expr))->expr_val_int ? true : false;
			(yyval.Expr) = pnt;				
		}else if((((yyvsp[-2].Expr))->expr_type =="boolean" && ((yyvsp[0].Expr))->expr_type =="boolean")){
			pnt->expr_type ="boolean";
			pnt->expr_val_bool = ((yyvsp[-2].Expr))->expr_val_bool == ((yyvsp[0].Expr))->expr_val_bool ? true : false;	
			(yyval.Expr) = pnt;
		}else{
          yyerror("Operands of != Operation should have INTEGER or BOOLEAN  type");
		}
        }
#line 2048 "parser.tab.c"
    break;

  case 78: /* expr: expr TOKEN_NOTEQUAL expr  */
#line 614 "parser.y"
                {
		struct ExprStruct* pnt = new ExprStruct();
		if((((yyvsp[-2].Expr))->expr_type =="int" && ((yyvsp[0].Expr))->expr_type =="int")){
			pnt->expr_type ="boolean";
			pnt->expr_val_bool = ((yyvsp[-2].Expr))->expr_val_int != ((yyvsp[0].Expr))->expr_val_int ? true : false;	
			(yyval.Expr) = pnt;	
		}else if((((yyvsp[-2].Expr))->expr_type =="boolean" && ((yyvsp[0].Expr))->expr_type =="boolean")){
			pnt->expr_type ="boolean";
			pnt->expr_val_bool = ((yyvsp[-2].Expr))->expr_val_bool != ((yyvsp[0].Expr))->expr_val_bool ? true : false;			
			(yyval.Expr) = pnt;
		}else{
          yyerror("Operands of != Operation should have INTEGER or BOOLEAN  type");
		}	
    }
#line 2067 "parser.tab.c"
    break;

  case 79: /* expr: expr TOKEN_PLUS expr  */
#line 629 "parser.y"
        {
		struct ExprStruct* pnt = new ExprStruct();		
		if(((yyvsp[-2].Expr))->expr_type !="int" || ((yyvsp[0].Expr))->expr_type !="int")
          yyerror("Operands of Plus Operation should have int type");
		pnt->expr_type ="int";
		pnt->expr_val_int =((yyvsp[-2].Expr))->expr_val_int+((yyvsp[0].Expr))->expr_val_int;
		(yyval.Expr) = pnt;
    }
#line 2080 "parser.tab.c"
    break;

  case 80: /* expr: expr TOKEN_MINUS expr  */
#line 638 "parser.y"
        {
		struct ExprStruct* pnt = new ExprStruct();		
		if(((yyvsp[-2].Expr))->expr_type !="int" || ((yyvsp[0].Expr))->expr_type !="int")
          yyerror("Operands of Minus Operation should have int type");
		pnt->expr_type ="int";
		pnt->expr_val_int =((yyvsp[-2].Expr))->expr_val_int-((yyvsp[0].Expr))->expr_val_int;
		(yyval.Expr) = pnt;
    }
#line 2093 "parser.tab.c"
    break;

  case 81: /* expr: expr TOKEN_DIVISION expr  */
#line 647 "parser.y"
        {
		struct ExprStruct* pnt = new ExprStruct();
		if(((yyvsp[-2].Expr))->expr_type !="int" || ((yyvsp[0].Expr))->expr_type !="int")
          yyerror("Operands of Division Operation should have int type");
		if(((yyvsp[0].Expr))->expr_val_int == 0){
			cout<<"\nWARNING: ***********YOU CANNOT DIVIDE NUMBERS BY ZERO***********\n";
		}
		pnt->expr_type ="int";
		pnt->expr_val_int =((yyvsp[-2].Expr))->expr_val_int / ((yyvsp[0].Expr))->expr_val_int;
		(yyval.Expr) = pnt;
    }
#line 2109 "parser.tab.c"
    break;

  case 82: /* expr: expr TOKEN_MODULO expr  */
#line 659 "parser.y"
        {
		struct ExprStruct* pnt = new ExprStruct();	
		if(((yyvsp[-2].Expr))->expr_type !="int" || ((yyvsp[0].Expr))->expr_type !="int")
          yyerror("Operands of Modulo Operation should have int type");
		pnt->expr_type ="int";
		pnt->expr_val_int =((yyvsp[-2].Expr))->expr_val_int % ((yyvsp[0].Expr))->expr_val_int;
		(yyval.Expr) = pnt;
    }
#line 2122 "parser.tab.c"
    break;

  case 83: /* expr: expr TOKEN_MULTIPLICATION expr  */
#line 668 "parser.y"
        {
		struct ExprStruct* pnt = new ExprStruct();		
		if(((yyvsp[-2].Expr))->expr_type !="int" || ((yyvsp[0].Expr))->expr_type !="int")
          yyerror("Operands of Multiplication Operation should have int type");
		pnt->expr_type ="int";
		pnt->expr_val_int =((yyvsp[-2].Expr))->expr_val_int * ((yyvsp[0].Expr))->expr_val_int;
		(yyval.Expr) = pnt;
    }
#line 2135 "parser.tab.c"
    break;

  case 84: /* expr: expr TOKEN_OR expr  */
#line 677 "parser.y"
        {
		struct ExprStruct* pnt = new ExprStruct();		
		if(((yyvsp[-2].Expr))->expr_type !="boolean" || ((yyvsp[0].Expr))->expr_type !="boolean")
          yyerror("Operands of OR Operation should have boolean type");
		pnt->expr_type ="boolean";
		pnt->expr_val_bool =((yyvsp[-2].Expr))->expr_val_bool || ((yyvsp[0].Expr))->expr_val_bool;
		(yyval.Expr) = pnt;
    }
#line 2148 "parser.tab.c"
    break;

  case 85: /* expr: expr TOKEN_AND expr  */
#line 686 "parser.y"
        {
		struct ExprStruct* pnt = new ExprStruct();		
		if(((yyvsp[-2].Expr))->expr_type !="boolean" || ((yyvsp[0].Expr))->expr_type !="boolean")
          yyerror("Operands of AND Operation should have boolean type");
		pnt->expr_type ="boolean";
		pnt->expr_val_bool =((yyvsp[-2].Expr))->expr_val_bool && ((yyvsp[0].Expr))->expr_val_bool;
		(yyval.Expr) = pnt;	
    }
#line 2161 "parser.tab.c"
    break;

  case 86: /* expr: TOKEN_MINUS expr  */
#line 695 "parser.y"
        {
		struct ExprStruct* pnt = new ExprStruct();
		if (((yyvsp[0].Expr))->expr_type!= "int") yyerror("Operand of MINUS Operation should have INTEGER type");
		pnt->expr_type ="int";
		pnt->expr_val_int = -((yyvsp[0].Expr))->expr_val_int;
		(yyval.Expr) = pnt;
	}
#line 2173 "parser.tab.c"
    break;

  case 87: /* expr: TOKEN_LOGICOP expr  */
#line 702 "parser.y"
                             { //* !EXPR
		struct ExprStruct* pnt = new ExprStruct();			
		if(((yyvsp[0].Expr))->expr_type !="boolean")
          yyerror("Error: type of expression in not Operation should be boolean");
		pnt->expr_type ="boolean";
		pnt->expr_val_bool =((yyvsp[0].Expr))->expr_val_bool ==true ? false : true;
		(yyval.Expr) = pnt;
	}
#line 2186 "parser.tab.c"
    break;

  case 88: /* expr: TOKEN_LP expr TOKEN_RP  */
#line 711 "parser.y"
        {  
		struct ExprStruct* pnt = new ExprStruct(); 
		pnt->expr_type = ((yyvsp[-1].Expr))->expr_type;
		if(pnt->expr_type == "int"){
			pnt->expr_val_int = ((yyvsp[-1].Expr))->expr_val_int;
		}else if(pnt->expr_type == "boolean"){
			pnt->expr_val_bool = ((yyvsp[-1].Expr))->expr_val_bool;
		}else if(pnt->expr_type == "char"){
			pnt->expr_val_char = ((yyvsp[-1].Expr))->expr_val_char;
		}
		(yyval.Expr) = pnt;
	}
#line 2203 "parser.tab.c"
    break;

  case 89: /* $@11: %empty  */
#line 724 "parser.y"
                            {currentScope=currentScope+" "+"if";}
#line 2209 "parser.tab.c"
    break;

  case 90: /* $@12: %empty  */
#line 725 "parser.y"
                 {			
			 if(((yyvsp[0].Expr))->expr_type!="boolean"){
				 yyerror("Error: type of expression in IF statment should be boolean");
			 }
		}
#line 2219 "parser.tab.c"
    break;

  case 91: /* $@13: %empty  */
#line 730 "parser.y"
                {
			currentScope.erase(currentScope.size()-(strlen("if")+1),strlen("if")+1);
		 	currentScope=currentScope+" "+"else";
		}
#line 2228 "parser.tab.c"
    break;

  case 95: /* $@14: %empty  */
#line 737 "parser.y"
                      {currentScope=currentScope+" "+"for";}
#line 2234 "parser.tab.c"
    break;

  case 96: /* $@15: %empty  */
#line 739 "parser.y"
                {
			
			if(((yyvsp[0].Expr))->expr_type !="int") yyerror("type of START counter of FOR LOOP should be INTEGER");
		}
#line 2243 "parser.tab.c"
    break;

  case 97: /* $@16: %empty  */
#line 744 "parser.y"
                {
		if(((yyvsp[0].Expr))->expr_type !="int") yyerror("type of END counter of FOR LOOP should be INTEGER");	
		}
#line 2251 "parser.tab.c"
    break;

  case 98: /* stmt_for: TOKEN_LOOP $@14 TOKEN_ID TOKEN_ASSIGNOP expr $@15 TOKEN_COMMA expr $@16 block  */
#line 747 "parser.y"
                       {currentScope.erase(currentScope.size()-(string("for").size()+1),string("for").size()+1);}
#line 2257 "parser.tab.c"
    break;

  case 99: /* stmt_return: TOKEN_RETURN  */
#line 750 "parser.y"
                        {
				struct Function *func = getFunction(current_func);
				if(func->return_type != "void") yyerror("Error: function *"+ current_func+"* should have a return value!"); //*CHECK FOR EQUAL TYPES
			}
#line 2266 "parser.tab.c"
    break;

  case 100: /* stmt_return: TOKEN_RETURN expr  */
#line 755 "parser.y"
                        {				
				struct Function *func = getFunction(current_func);              
 				if(func->return_type != ((yyvsp[0].Expr))->expr_type) yyerror("Error: return type does not match with declaration!"); //*CHECK FOR EQUAL TYPES
				if(func->return_type !="int" && func->return_type !="boolean") yyerror("Error: return type should be *boolean* or *int*"); //*CHECK FOR INT,BOOL
			}
#line 2276 "parser.tab.c"
    break;


#line 2280 "parser.tab.c"

      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", YY_CAST (yysymbol_kind_t, yyr1[yyn]), &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;

  *++yyvsp = yyval;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */
  {
    const int yylhs = yyr1[yyn] - YYNTOKENS;
    const int yyi = yypgoto[yylhs] + *yyssp;
    yystate = (0 <= yyi && yyi <= YYLAST && yycheck[yyi] == *yyssp
               ? yytable[yyi]
               : yydefgoto[yylhs]);
  }

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYSYMBOL_YYEMPTY : YYTRANSLATE (yychar);
  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
      yyerror (YY_("syntax error"));
    }

  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:
  /* Pacify compilers when the user code never invokes YYERROR and the
     label yyerrorlab therefore never appears in user code.  */
  if (0)
    YYERROR;
  ++yynerrs;

  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  /* Pop stack until we find a state that shifts the error token.  */
  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYSYMBOL_YYerror;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYSYMBOL_YYerror)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;


      yydestruct ("Error: popping",
                  YY_ACCESSING_SYMBOL (yystate), yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", YY_ACCESSING_SYMBOL (yyn), yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturnlab;


/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturnlab;


/*-----------------------------------------------------------.
| yyexhaustedlab -- YYNOMEM (memory exhaustion) comes here.  |
`-----------------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  goto yyreturnlab;


/*----------------------------------------------------------.
| yyreturnlab -- parsing is finished, clean up and return.  |
`----------------------------------------------------------*/
yyreturnlab:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  YY_ACCESSING_SYMBOL (+*yyssp), yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif

  return yyresult;
}

#line 762 "parser.y"


int main (int argc, char *argv[]){
	int flag;
	yyin = fopen(argv[1], "r");
	if(yyin == 0){
	cout << "Unable to open the file" << endl;
    return 0;
	}
	flag = yyparse();
	fclose(yyin);
	cout<<"\nParsing finished!\n";
	return flag;
}

void yyerror(string error_message){
  cout<<"\nparser gave error\n"<<error_message<<" Error at line "<<numLines<<endl;
  exit(-1);
}


void pushSymbol(string name,string scope,string reg,string type,bool is_array,int array_size){
  struct Symbol *newSymbol =new Symbol();
  newSymbol->name=name;
  newSymbol->scope=scope;  
  newSymbol->reg=reg;
  newSymbol->symbol_type=type;
  newSymbol->is_array = is_array;  
  newSymbol->array_size = array_size;  
  symbols.push_back(newSymbol);  
}


void pushFunction(string name,string return_type,int num_args , string* types)
{   
  struct Function* newFunction = new Function();
  newFunction->name=name;  
  newFunction->return_type=return_type;
  newFunction->num_args=num_args;
  newFunction->args_types = types;  
  functions.push_back(newFunction);  
}

struct Symbol* getSymbol(string name,string scope,bool is_array){
  for(int i=0;i<symbols.size();i++)
  {	  
    if ((name == symbols[i]->name) && (symbols[i]->scope==scope) && (symbols[i]->is_array == is_array)){		
      return symbols[i];
    }
  }
  int search_index=scope.find_last_of(" ");
  while(search_index!=-1){
    string newscope=scope.substr(0,search_index);	
    for(int i=0;i<symbols.size();i++)
    {		 
       if ((name == symbols[i]->name) && (symbols[i]->scope==newscope) && (symbols[i]->is_array == is_array)){				   
        return symbols[i];		
      }
    }	
    search_index=newscope.find_last_of(" ");
  }
  return NULL;
}

struct Function* getFunction(string name){
  for(int i=0;i<functions.size();i++)
    if( name == functions[i]->name)
      return functions[i];
  return NULL;
}


/*Code Generation Section*/
string getNewRegister(char registerType){
//   registerType : 't','s','a'
  switch(registerType){
		case 't':
				for(int i=0; i<=9; i++)
					if(t_registers_state[i] == 0)
						{t_registers_state[i] = 1;return "$t"+convertToString(i);}
				break;
		case 's':
				for(int i=0; i<=7; i++)
					if(s_registers_state[i] == 0)
						{s_registers_state[i] = 1;return "$s"+convertToString(i);}
				break;
		case 'a':
				for(int i=0; i<=3; i++)
					if(a_registers_state[i] == 0)
						{a_registers_state[i] = 1;return "$a"+convertToString(i);}
				break;
	}
  return "$";
}

void releaseRegister(string reg){
//   reg ~ '$t0'
  switch(reg[1]){
		case 't':
			t_registers_state[reg[2]-'0'] = 0;
			break;
		case 's':
			s_registers_state[reg[2]-'0'] = 0;
			break;
		case 'a':
			a_registers_state[reg[2]-'0'] = 0;
			break;
	}
}

string convertToString(int i){	
	char str[12];
	sprintf(str,"%d",i);	
	string ans(str);	
	return ans;
}

int convertStringToInt(string str)
{
	stringstream res(str);
	int x = 0;
	res >> x;
	return x;
}
