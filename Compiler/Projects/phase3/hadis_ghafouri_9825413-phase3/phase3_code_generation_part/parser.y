%{
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
%}


%union{
	char* str_val;
	int int_val;
	bool bool_val;	
	char char_val;	
	struct ExprStruct* Expr;
	struct ArgsStruct* Args;	
}


/************TOKENS************/
%token <str_val> TOKEN_ID
%token <int_val> TOKEN_DECIMALCONST
%token <char_val> TOKEN_CHARCONST
%token <int_val> TOKEN_HEXADECIMALCONST  
%token <str_val> TOKEN_STRINGCONST   
%token <bool_val> TOKEN_BOOLEANCONST 
%token  TOKEN_PROGRAMCLASS
%token	TOKEN_MAINFUNC 
%token	TOKEN_BREAKSTMT 
%token	TOKEN_CALLOUT
%token	TOKEN_CLASS
%token	TOKEN_CONTINUESTMT
%token	TOKEN_VOIDTYPE
%token	TOKEN_BOOLEANTYPE
%token	TOKEN_INTTYPE  
%token	TOKEN_IFCONDITION 
%token	TOKEN_ELSECONDITION 
%token	TOKEN_LOOP 
%token	TOKEN_RETURN 
%token 	TOKEN_LP TOKEN_RP
%token	TOKEN_LCB TOKEN_RCB
%token	TOKEN_LB TOKEN_RB
%token	TOKEN_SEMICOLON TOKEN_COMMA 
%token 	TOKEN_LOGICOP
%token	TOKEN_NOTEQUAL TOKEN_EQUAL
%token	TOKEN_AND TOKEN_OR
%token	TOKEN_ASSIGNOP TOKEN_MINUS_EQUAL TOKEN_PLUS_EQUAL
%token	TOKEN_PLUS TOKEN_MINUS TOKEN_MULTIPLICATION TOKEN_DIVISION TOKEN_MODULO
%token	TOKEN_GREATER_EQUAL TOKEN_LESS_EQUAL TOKEN_GREATER TOKEN_LESS


/************Priority************/
%right TOKEN_ASSIGNOP TOKEN_MINUS_EQUAL TOKEN_PLUS_EQUAL
%left TOKEN_OR
%left TOKEN_AND
%left TOKEN_NOTEQUAL TOKEN_EQUAL
%left TOKEN_GREATER_EQUAL TOKEN_LESS_EQUAL TOKEN_GREATER TOKEN_LESS
%left TOKEN_PLUS TOKEN_MINUS
%left TOKEN_MULTIPLICATION TOKEN_DIVISION TOKEN_MODULO
%right TOKEN_LOGICOP  
%left TOKEN_LB TOKEN_RB
%left TOKEN_LP TOKEN_RP

/********NON-TERMINALS*********/
%nterm <Expr> expr
%nterm <Args> call_params
%nterm <Args> method_args
%nterm <str_val> method_id
%nterm <str_val> type
%nterm <str_val> method_arg
%nterm <str_val> method_call
%nterm  program
%nterm  decl_fields
%nterm  decl_field
%nterm  decl_methods
%nterm  decl_method
%nterm  block
%nterm  declare_vars
%nterm  declare_var
%nterm ids
%nterm statments
%nterm statment
%nterm optional_callout_args
%nterm callout_args
%nterm stmt_if
%nterm optional_else
%nterm stmt_for
%nterm stmt_return
%nterm callout_arg
%nterm names

%start program

%%
program : TOKEN_CLASS TOKEN_PROGRAMCLASS TOKEN_LCB {currentScope += " program"; } decl_fields  decl_methods  TOKEN_RCB {currentScope.erase(currentScope.size()-(strlen("program")+1),strlen("program")+1);};
decl_fields :decl_fields decl_field
            | /*empty*/;

decl_field : names TOKEN_SEMICOLON;		

names: type TOKEN_ID
	{		
		struct Symbol* scalar_symbol=getSymbol($2,currentScope,false);		
		if(scalar_symbol == NULL){ //add symbol to table		
		pushSymbol($2,currentScope,getNewRegister('s'),$1,false,0);			
		}else{
			yyerror("variable was defined before!");
		}
		field_type = $1;			
	}
	| type TOKEN_ID TOKEN_LB expr TOKEN_RB 
		{
			if(($4)->expr_type !="int"){
				yyerror("Error: size of array should be integer!!");
			}else if(($4)->expr_val_int <0){
				yyerror("Error: size of array should be positive number!!");
			}else{
				struct Symbol* array_symbol=getSymbol($2,currentScope,true);
				if(array_symbol == NULL){ //add symbol to table
				pushSymbol($2,currentScope,getNewRegister('s'),$1,true,($4)->expr_val_int);	
				}else{
					yyerror("variable was defined before!");
				}
			}
			field_type = $1;
		}
	| names TOKEN_COMMA TOKEN_ID 
	{
		struct Symbol* scalar_symbol=getSymbol($3,currentScope,false);
		if(scalar_symbol == NULL){ //add symbol to table
		pushSymbol($3,currentScope,getNewRegister('s'),field_type,false,0);	
		}else{
			yyerror("variable was defined before!");
		}
	}
	| names TOKEN_COMMA TOKEN_ID TOKEN_LB expr TOKEN_RB		
	{
		if(($5)->expr_type !="int"){
			yyerror("Error: size of array should be integer!!");
		}else if(($5)->expr_val_int <0){
			yyerror("Error: size of array should be positive number!!");
		}else{
			struct Symbol* array_symbol=getSymbol($3,currentScope,true);
			if(array_symbol == NULL){ //add symbol to table
			pushSymbol($3,currentScope,getNewRegister('s'),field_type,true,($5)->expr_val_int);	
			}else{
				yyerror("variable was defined before!");
			}
		}
	};

decl_methods : decl_method decl_methods
            |/*empty*/;

decl_method : TOKEN_VOIDTYPE method_id {currentScope =currentScope+" "+($2);} TOKEN_LP method_args TOKEN_RP	
			{
				current_func=$2;
				if(strcmp($2,"main")==0 && ($5)->num_args !=0){
					yyerror("main functioin cannot have arguments!");
				}
				pushFunction($2,"void",($5)->num_args,($5)->args_types);
			}  block{ current_func ="" ;currentScope.erase(currentScope.size()-(string($2).size()+1),string($2).size()+1);};
			|type method_id {currentScope =currentScope+" "+($2);} TOKEN_LP method_args TOKEN_RP
			{
				current_func=$2;						
				pushFunction($2,$1,($5)->num_args,($5)->args_types);
			} block { current_func ="" ;currentScope.erase(currentScope.size()-(string($2).size()+1),string($2).size()+1);};

method_id : TOKEN_ID  {$$=$1;} |TOKEN_MAINFUNC {$$=strdup("main");};

block : TOKEN_LCB declare_vars statments TOKEN_RCB
		{//CG
          MIPS_FILE = fopen("MIPS.asm", "a+");
          fprintf(MIPS_FILE,"\tL%d:\n", Label);
          fclose(MIPS_FILE);
        };

declare_vars : declare_var declare_vars
		| /*empty*/;

declare_var : type {var_type =$1;} TOKEN_ID 
	{
		struct Symbol* scalar_symbol=getSymbol($3,currentScope,false);
		if(scalar_symbol == NULL){ //add symbol to table		
		pushSymbol($3,currentScope,getNewRegister('s'),$1,false,0);	
		}else{
			yyerror("variable was defined before");
		}			
	}
	ids TOKEN_SEMICOLON;

ids :TOKEN_COMMA TOKEN_ID
	 {
		struct Symbol* scalar_symbol=getSymbol($2,currentScope,false);
		if(scalar_symbol == NULL){ //add symbol to table
		pushSymbol($2,currentScope,getNewRegister('s'),var_type,false,0);	
		}else{
			yyerror("variable was defined before");
		}			 
	 } ids 
	|/*empty*/;

type : TOKEN_INTTYPE {$$ = strdup("int");}
		| TOKEN_BOOLEANTYPE {$$ = strdup("boolean");}; 

statments :statment statments
		|  /*empty*/;

statment : TOKEN_ID TOKEN_ASSIGNOP expr TOKEN_SEMICOLON  //*=  SCALAR VARS
		{			
			struct Symbol* scalar_symbol=getSymbol($1,currentScope,false);
			if(scalar_symbol == NULL) yyerror("Error: variable was not defined yet!");			
			if(scalar_symbol->symbol_type != ($3)->expr_type) yyerror("Operands of = Operation should have same type");
			//*Code Generation	
            string Rs=Stack.top();
            Stack.pop();
            MIPS_FILE = fopen("MIPS.asm", "a+");
            if(Rs[0]!='$')
            	fprintf(MIPS_FILE,"\taddi %s,$zero,%s\n", (getSymbol($1,currentScope)->reg).c_str(), Rs.c_str());
            else{
            	fprintf(MIPS_FILE,"\tmove %s,%s\n", (getSymbol($1,currentScope)->reg).c_str(), Rs.c_str());
            	if(Rs[1] == 't')
            	releaseRegister(Rs);
            }
            fclose(MIPS_FILE);				
		}
		| TOKEN_ID TOKEN_MINUS_EQUAL expr TOKEN_SEMICOLON   //* -= SCALAR VARS
		{
			struct Symbol* scalar_symbol=getSymbol($1,currentScope,false);
			if(scalar_symbol == NULL) yyerror("Error: variable was not defined yet!");	
			if((scalar_symbol->symbol_type != "int") || (($3)->expr_type != "int") ){
				yyerror("Operands of -= Operation should have INTEGER type");
			}	
		//*Code Generation
        string Rs=Stack.top();
        Stack.pop();
        MIPS_FILE = fopen("MIPS.asm", "a+");
        if(Rs[0]!='$'){
        	Rs = convertToString(convertStringToInt((scalar_symbol->reg).substr(1)) - convertStringToInt(Rs));
        	fprintf(MIPS_FILE,"\taddi %s,$zero,%s\n", (getSymbol($1,currentScope)->reg).c_str(), Rs.c_str());
        }
        else{
        	string RRs = (getSymbol($1,currentScope)->reg).c_str();
        	fprintf(MIPS_FILE,"\tsub %s,%s,%s\n", RRs, RRs , Rs.c_str());
        	if(Rs[1] == 't')
        		releaseRegister(Rs);
        }
        fclose(MIPS_FILE);		
		}
		| TOKEN_ID TOKEN_PLUS_EQUAL expr TOKEN_SEMICOLON   //* += SCALAR VARS
		{
		struct Symbol* scalar_symbol=getSymbol($1,currentScope,false);
		if(scalar_symbol == NULL)yyerror("Error: variable was not defined yet!");
		if((scalar_symbol->symbol_type != "int") || (($3)->expr_type != "int") ){
			yyerror("Operands of += Operation should have same type");
		}	
		//*Code Generation
        string Rs=Stack.top();
        Stack.pop();
        MIPS_FILE = fopen("MIPS.asm", "a+");
        if(Rs[0]!='$'){
        	Rs = convertToString(convertStringToInt((scalar_symbol->reg).substr(1)) - convertStringToInt(Rs));//check symbol.val
        	fprintf(MIPS_FILE,"\taddi %s,$zero,%s\n", (getSymbol($1,currentScope)->reg).c_str(), Rs.c_str());
        }
        else{
        	string TTs = (getSymbol($1,currentScope)->reg).c_str();
        	fprintf(MIPS_FILE,"\tadd %s,%s\n", TTs, TTs, Rs.c_str());
        	if(Rs[1] == 't')
        		releaseRegister(Rs);
        }
        fclose(MIPS_FILE);		
		}
		| TOKEN_ID TOKEN_LB expr TOKEN_RB TOKEN_ASSIGNOP expr TOKEN_SEMICOLON   //*= ARRAYS
		{
			if(($3)->expr_type !="int"){
				yyerror("Error: size of array should be integer!");
			}else if(($3)->expr_val_int <0){
				yyerror("Error: size of array can not be negative number!");
			}else{
				struct Symbol* array_symbol=getSymbol($1,currentScope,true);
				if(array_symbol == NULL){ 
				yyerror("Error: array was not defined yet!");
				}else{
					if(($3)->expr_val_int > array_symbol->array_size){
					yyerror("Error: array index should be in range of array size!!");		
					}	
					if(array_symbol->symbol_type != ($3)->expr_type){
					yyerror("Operands of = Operation should have same type");
					}				
				}
			}
		}
		| TOKEN_ID TOKEN_LB expr TOKEN_RB TOKEN_MINUS_EQUAL expr TOKEN_SEMICOLON  //* -= ARRAYS
		{
			if(($3)->expr_type !="int"){
				yyerror("Error: size of array should be integer!!");
			}else if(($3)->expr_val_int <0){
				yyerror("Error: size of array should be positive number!!");
			}else{
				struct Symbol* array_symbol=getSymbol($1,currentScope,true);
				if(array_symbol == NULL){ 
				yyerror("Error: array was not defined yet!");
				}else{
					if(($3)->expr_val_int > array_symbol->array_size){
					yyerror("Error: array index should be in range of array size!!");		
					}			
					if(( array_symbol->symbol_type != "int") || (($3)->expr_type != "int") ){
						yyerror("Operands of -= Operation should have INTEGER type");
					}				
				}
			}
		}
		| TOKEN_ID TOKEN_LB expr TOKEN_RB TOKEN_PLUS_EQUAL expr TOKEN_SEMICOLON  //* += ARRAYS
		{
			if(($3)->expr_type !="int"){
				yyerror("Error: size of array should be integer!!");
			}else if(($3)->expr_val_int <0){
				yyerror("Error: size of array should be positive number!!");
			}else{
				struct Symbol* array_symbol=getSymbol($1,currentScope,true);
				if(array_symbol == NULL){ 
				yyerror("Error: array was not defined yet!");
				}else{
					if(($3)->expr_val_int > array_symbol->array_size){
					yyerror("Error: array index should be in range of array size!!");		
					}
					if(( array_symbol->symbol_type != "int") || (($3)->expr_type != "int") ){
						yyerror("Operands of += Operation should have INTEGER type");
					}							
				}
			}
		}
		| method_call TOKEN_SEMICOLON
		| stmt_if
		| stmt_for
		| stmt_return TOKEN_SEMICOLON
		| TOKEN_BREAKSTMT {if(currentScope.find("for") == string::npos) yyerror("Error:Can not use BREAK out of FOR loop!");} TOKEN_SEMICOLON
		| TOKEN_CONTINUESTMT {if(currentScope.find("for") == string::npos) yyerror("Error:Can not use CONTINUE out of FOR loop!");} TOKEN_SEMICOLON
		| block;


method_call : TOKEN_ID TOKEN_LP call_params TOKEN_RP
			{
				struct Function *func = getFunction($1);
				if(func==NULL) yyerror(strdup("cannot use undefined function"));				
				if(func->num_args != ($3)->num_args) yyerror("number of used arguments does not match with defined function!!");
				sprintf($$, "%s", func->return_type.c_str()); //!SAVE RETURN TYPE				
				for(int i=0;i<func->num_args;i++){
					if(func->args_types[i] != ($3)->args_types[i]){
						yyerror("type of argument with number "+ convertToString(i)+" does not match with defined function!");
					}
				}
		
         if(func==NULL) yyerror(strdup("undefined function"));
         else {
           if(func->num_args != ($3)->num_args) yyerror(strdup("the number of arguments does not match"));
           else{
            //*Code Generation
             MIPS_FILE = fopen("MIPS.asm", "a+");
             string arguments[4];
             for(int i=($3)->num_args-1 ; i>=0 ; i--){
               arguments[i] = Stack.top();
               Stack.pop();
             }
             for(int i=0; i<($3)->num_args; i++){
   				if(arguments[i][0]!='$')
   					fprintf(MIPS_FILE,"\taddi $a%d,$zero,%s\n",i, arguments[i].c_str());
   				else
   					fprintf(MIPS_FILE,"\tmove $a%d,%s\n",i, arguments[i].c_str());
   				}
            fprintf(MIPS_FILE,"\tjal %s\n", $1);
  		    fclose(MIPS_FILE);
           }
         }			
			}
			| TOKEN_CALLOUT  TOKEN_LP TOKEN_STRINGCONST optional_callout_args TOKEN_RP;//TODO

call_params :
		{
			struct ArgsStruct* pnt = new ArgsStruct();
			pnt->num_args = 0;						
			$$ = pnt;		
		}
		| expr 
		{
			struct ArgsStruct* pnt = new ArgsStruct();
			pnt->num_args = 1;
			pnt->args_types = new string[1];
			pnt->args_types[0] = ($1)->expr_type;							
			$$ = pnt;	
		}
		| expr TOKEN_COMMA expr
		{
			struct ArgsStruct* pnt = new ArgsStruct();
			pnt->num_args = 2;
			pnt->args_types = new string[2];
			pnt->args_types[0] = ($1)->expr_type;
			pnt->args_types[1] = ($3)->expr_type;					
			$$ = pnt;	
		}
		| expr TOKEN_COMMA expr TOKEN_COMMA expr
		{
			struct ArgsStruct* pnt = new ArgsStruct();
			pnt->num_args = 3;
			pnt->args_types = new string[3];
			pnt->args_types[0] = ($1)->expr_type;
			pnt->args_types[1] = ($3)->expr_type;
			pnt->args_types[2] = ($5)->expr_type;			
			$$ = pnt;	
		}
		| expr TOKEN_COMMA expr TOKEN_COMMA expr TOKEN_COMMA expr
		{
			struct ArgsStruct* pnt = new ArgsStruct();
			pnt->num_args = 4;
			pnt->args_types = new string[4];
			pnt->args_types[0] = ($1)->expr_type;
			pnt->args_types[1] = ($3)->expr_type;
			pnt->args_types[2] = ($5)->expr_type;
			pnt->args_types[3] = ($7)->expr_type;
			$$ = pnt;			
		};

method_args :
		method_arg TOKEN_COMMA method_arg TOKEN_COMMA method_arg TOKEN_COMMA method_arg
		{
			struct ArgsStruct* pnt = new ArgsStruct();
			pnt->num_args = 4;
			pnt->args_types = new string[4];
			pnt->args_types[0] = $1;
			pnt->args_types[1] = $3;
			pnt->args_types[2] = $5;
			pnt->args_types[3] = $7;
			$$ = pnt;			
		}
		| method_arg TOKEN_COMMA method_arg TOKEN_COMMA method_arg
		{
			struct ArgsStruct* pnt = new ArgsStruct();
			pnt->num_args = 3;
			pnt->args_types = new string[3];
			pnt->args_types[0] = $1;
			pnt->args_types[1] = $3;
			pnt->args_types[2] = $5;			
			$$ = pnt;	
		}
		| method_arg TOKEN_COMMA method_arg 
		{
			struct ArgsStruct* pnt = new ArgsStruct();
			pnt->num_args = 2;
			pnt->args_types = new string[2];
			pnt->args_types[0] = $1;
			pnt->args_types[1] = $3;
			$$ = pnt;	
		}
		| method_arg
		{
			struct ArgsStruct* pnt = new ArgsStruct();
			pnt->num_args = 1;
			pnt->args_types = new string[1];
			pnt->args_types[0] = $1;
			$$ = pnt;	
		}
		|{
			struct ArgsStruct* pnt = new ArgsStruct();
			pnt->num_args = 0;						
			$$ = pnt;			
		};

method_arg : type TOKEN_ID
			{
				$$ = $1;
				//!check				
				struct Symbol* scalar_symbol=getSymbol($2,currentScope,false);
				if(scalar_symbol == NULL){ //add symbol to table
				pushSymbol($2,currentScope,getNewRegister('s'),$1,false,0);	
				}else{
					yyerror("variable was defined before");
				}				
			};
optional_callout_args : /*empty*/
					| TOKEN_COMMA callout_args;

callout_args : callout_arg
			| callout_arg TOKEN_COMMA callout_args;

expr :TOKEN_ID  //*  SCALAR VARS
		{
			struct Symbol* scalar_symbol = getSymbol($1,currentScope,false);
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
			$$ = pnt;
			Stack.push(scalar_symbol->reg);
			//!($$)->expr_val?
		}
		| TOKEN_ID TOKEN_LB expr TOKEN_RB //* ARRAYS
		{
			if(($3)->expr_type !="int"){
				yyerror("Error: size of array should be integer!!");
			}else if(($3)->expr_val_int <0){
				yyerror("Error: size of array should be positive number!!");
			}else{
				struct Symbol* array_symbol=getSymbol($1,currentScope,true);								
				if(array_symbol == NULL) yyerror("Error: array was not defined yet!");
				else{
					if(($3)->expr_val_int > array_symbol->array_size){
					yyerror("Error: array index should be in range of array size!!");				
					}
				    struct ExprStruct* pnt = new ExprStruct();
					pnt->expr_type = array_symbol->symbol_type;
					$$ = pnt;
					Stack.push(array_symbol->reg);
				}
			}
		}	
	| method_call 
    {
        if(strcmp(($1),"void")==0) yyerror("Error: cannot use void function in EXPRESSIONS");
        struct ExprStruct* pnt = new ExprStruct();
		pnt->expr_type = strdup($1);
        $$ = pnt;
    } //!SHOULD HAVE RETURN VALUE (AVOID void)
	| TOKEN_DECIMALCONST
	{		
		struct ExprStruct* pnt = new ExprStruct();
		pnt->expr_type ="int";
		pnt->expr_val_int = $1;		
		$$ = pnt;	
		Stack.push(convertToString($1));		
	}
	| TOKEN_HEXADECIMALCONST
	{			
		struct ExprStruct* pnt = new ExprStruct();
		pnt->expr_type ="int";
		pnt->expr_val_int = $1;
		$$ = pnt;
		//!CHECK
		Stack.push(convertToString($1));
	}
	| TOKEN_CHARCONST
	{
		struct ExprStruct* pnt= new ExprStruct();
		pnt->expr_type ="char";
		pnt->expr_val_char = $1;
		$$ = pnt;
		//!CHECK
	}
	| TOKEN_BOOLEANCONST 
	{			
		struct ExprStruct* pnt = new ExprStruct();
		pnt->expr_type ="boolean";
		pnt->expr_val_bool = $1;
		$$ = pnt;
		//!CHECK
	}
	| expr TOKEN_GREATER_EQUAL expr  //* EXPR >= EXPR
	{
		if(($1)->expr_type !="int" || ($3)->expr_type !="int")
          yyerror("Operands of >= Operation should have int type");
		struct ExprStruct* pnt = new ExprStruct();
		pnt->expr_type ="boolean";
		pnt->expr_val_bool = ($1)->expr_val_int >=($3)->expr_val_int?  true : false;		
		$$ = pnt;					
		//*Code Generation
        MIPS_FILE = fopen("MIPS.asm", "a+");        
  		string Rt = Stack.top();
        Stack.pop();
  		string Rs = Stack.top();
        Stack.pop();
        string Rd = getNewRegister('t');
  		if(Rs[0]!='$' && Rt[0]!='$')
  			fprintf(MIPS_FILE,"\taddi %s,$zero,%d\n", Rd.c_str(),convertStringToInt(Rs)>=convertStringToInt(Rt));
  		else if(Rs[0]!='$'){
          fprintf(MIPS_FILE,"\taddi %s,$zero,%s\n", Rd.c_str(), Rs.c_str());
  		  fprintf(MIPS_FILE,"\tslt %s,%s,%s\n", Rd.c_str(), Rd.c_str(), Rt.c_str());
        }
        else if(Rt[0]!='$')
          	fprintf(MIPS_FILE,"\tslti %s,%s,%s\n", Rd.c_str(), Rs.c_str(), Rt.c_str());
  		else
  			fprintf(MIPS_FILE,"\tslt %s,%s,%s\n", Rd.c_str(), Rs.c_str(), Rt.c_str());
        fprintf(MIPS_FILE,"\txori %s,%s,1\n", Rd.c_str(), Rd.c_str());
  		fclose(MIPS_FILE);
  		Stack.push(Rd);
    }
	| expr TOKEN_LESS_EQUAL expr  //* EXPR <= EXPR
	{ 
		if(($1)->expr_type !="int" || ($3)->expr_type !="int")
          yyerror("Operands of <= Operation should have int type");
		struct ExprStruct* pnt = new ExprStruct();
		pnt->expr_type ="boolean";
		pnt->expr_val_bool = ($1)->expr_val_int <=($3)->expr_val_int?  true : false;		
		$$ = pnt;
	   //*Code Generation
        MIPS_FILE = fopen("MIPS.asm", "a+");       
  		string Rt = Stack.top();
        Stack.pop();
  		string Rs = Stack.top();
        Stack.pop();
        string Rd = getNewRegister('t');
  		if(Rs[0]!='$' && Rt[0]!='$')
  			fprintf(MIPS_FILE,"\taddi %s,$zero,%d\n", Rd.c_str(),convertStringToInt(Rs)<=convertStringToInt(Rt));
  		else if(Rs[0]!='$'){
  			fprintf(MIPS_FILE,"\taddi %s,$zero,%s\n", Rd.c_str(), Rs.c_str());
  			fprintf(MIPS_FILE,"\tslt %s,%s,%s\n", Rd.c_str(), Rd.c_str(), Rt.c_str());
  		}
  		else if(Rt[0]!='$')
  			fprintf(MIPS_FILE,"\tslti %s,%s,%s\n", Rd.c_str(), Rs.c_str(), Rt.c_str());
  		else
  			fprintf(MIPS_FILE,"\tslt %s,%s,%s\n", Rd.c_str(), Rs.c_str(), Rt.c_str());
        fprintf(MIPS_FILE,"\txori %s,%s,1\n", Rd.c_str(), Rd.c_str());
  		fclose(MIPS_FILE);
  		Stack.push(Rd);	
    }
	| expr TOKEN_LESS expr  //* EXPR < EXPR
	{ 
		if(($1)->expr_type !="int" || ($3)->expr_type !="int")
        yyerror("Operands of < Operation should have int type");
		struct ExprStruct* pnt = new ExprStruct();
		pnt->expr_type ="boolean";
		pnt->expr_val_bool = ($1)->expr_val_int < ($3)->expr_val_int ? true : false;		
	   	$$ = pnt;

		//*Code Generation
        MIPS_FILE = fopen("MIPS.asm", "a+");        
  		string Rt = Stack.top();
        Stack.pop();
  		string Rs = Stack.top();
        Stack.pop();
        string Rd = getNewRegister('t');
  		if(Rs[0]!='$' && Rt[0]!='$')
  			fprintf(MIPS_FILE,"\taddi %s,$zero,%d\n", Rd.c_str(),convertStringToInt(Rs)<convertStringToInt(Rt));
  		else if(Rs[0]!='$'){
  			fprintf(MIPS_FILE,"\taddi %s,$zero,%s\n", Rd.c_str(), Rs.c_str());
  			fprintf(MIPS_FILE,"\tslt %s,%s,%s\n", Rd.c_str(), Rd.c_str(), Rt.c_str());
  		}
  		else if(Rt[0]!='$')
  			fprintf(MIPS_FILE,"\tslti %s,%s,%s\n", Rd.c_str(), Rs.c_str(), Rt.c_str());
  		else
  			fprintf(MIPS_FILE,"\tslt %s,%s,%s\n", Rd.c_str(), Rs.c_str(), Rt.c_str());
  		fclose(MIPS_FILE);
  		Stack.push(Rd);	
    }
	| expr TOKEN_GREATER expr  //* EXPR > EXPR
	{ 
		if(($1)->expr_type !="int" || ($3)->expr_type !="int")
          yyerror("Operands of > Operation should have int type");
		struct ExprStruct* pnt = new ExprStruct();
		pnt->expr_type ="boolean";
		pnt->expr_val_bool = ($1)->expr_val_int > ($3)->expr_val_int ? true : false;		
		$$ = pnt;		
		//*Code Generation
        MIPS_FILE = fopen("MIPS.asm", "a+");        
  		string Rt = Stack.top();
        Stack.pop();
  		string Rs = Stack.top();
        Stack.pop();
        string Rd = getNewRegister('t');
  		if(Rs[0]!='$' && Rt[0]!='$')
  			fprintf(MIPS_FILE,"\taddi %s,$zero,%d\n", Rd.c_str(),convertStringToInt(Rs)>convertStringToInt(Rt));
  		else if(Rs[0]!='$')
          fprintf(MIPS_FILE,"\tslti %s,%s,%s\n", Rd.c_str(), Rt.c_str(), Rs.c_str());
  		else if(Rt[0]!='$'){
          fprintf(MIPS_FILE,"\taddi %s,$zero,%s\n", Rd.c_str(), Rt.c_str());
  		  fprintf(MIPS_FILE,"\tslt %s,%s,%s\n", Rd.c_str(), Rd.c_str(), Rs.c_str());
        }
  		else
  		 	fprintf(MIPS_FILE,"\tslt %s,%s,%s\n", Rd.c_str(), Rt.c_str(), Rs.c_str());
  		fclose(MIPS_FILE);
  		Stack.push(Rd);
    }
	| expr TOKEN_EQUAL expr //* EXPR == EXPR
		{
		struct ExprStruct* pnt = new ExprStruct();
		if((($1)->expr_type =="int" && ($3)->expr_type =="int")){
			//!TEST**************************************
			pnt->expr_type ="boolean";
			pnt->expr_val_bool = ($1)->expr_val_int == ($3)->expr_val_int ? true : false;
			$$ = pnt;				
		}else if((($1)->expr_type =="boolean" && ($3)->expr_type =="boolean")){
			pnt->expr_type ="boolean";
			pnt->expr_val_bool = ($1)->expr_val_bool == ($3)->expr_val_bool ? true : false;	
			$$ = pnt;
		}else{
          yyerror("Operands of != Operation should have INTEGER or BOOLEAN  type");
		}
		
		//*Code Generation
        MIPS_FILE = fopen("MIPS.asm", "a+");        
  		string Rt = Stack.top();
        Stack.pop();
  		string Rs = Stack.top();
        Stack.pop();
        string Rd1 = getNewRegister('t');
        string Rd2 = getNewRegister('t');
  		if(Rs[0]!='$' && Rt[0]!='$')
  			fprintf(MIPS_FILE,"\taddi %s,$zero,%d\n", Rd1.c_str(),convertStringToInt(Rs)==convertStringToInt(Rt));
  		else if(Rs[0]!='$'){
          fprintf(MIPS_FILE,"\taddi %s,$zero,%s\n", Rd1.c_str(), Rs.c_str());
  		  fprintf(MIPS_FILE,"\tslt %s,%s,%s\n", Rd1.c_str(), Rd1.c_str(), Rt.c_str());
          fprintf(MIPS_FILE,"\tslti %s,%s,%s\n", Rd2.c_str(), Rt.c_str(), Rs.c_str());
  		  fprintf(MIPS_FILE,"\txor %s,%s,%s\n", Rd1.c_str(), Rd1.c_str(), Rd2.c_str());
        }
        else if(Rt[0]!='$'){
          fprintf(MIPS_FILE,"\taddi %s,$zero,%s\n", Rd2.c_str(), Rt.c_str());
  		  fprintf(MIPS_FILE,"\tslt %s,%s,%s\n", Rd2.c_str(), Rd2.c_str(), Rs.c_str());
  		  fprintf(MIPS_FILE,"\tslti %s,%s,%s\n", Rd1.c_str(), Rs.c_str(), Rt.c_str());
  		  fprintf(MIPS_FILE,"\txor %s,%s,%s\n", Rd1.c_str(), Rd1.c_str(), Rd2.c_str());
        }
  		else{
  			fprintf(MIPS_FILE,"\tslt %s,%s,%s\n", Rd1.c_str(), Rs.c_str(), Rt.c_str());
  			fprintf(MIPS_FILE,"\tslt %s,%s,%s\n", Rd2.c_str(), Rt.c_str(), Rs.c_str());
  			fprintf(MIPS_FILE,"\txor %s,%s,%s\n", Rd1.c_str(), Rd1.c_str(), Rd2.c_str());
  		}
        releaseRegister(Rd2);
        if(Rs[1] == 't')releaseRegister(Rs);			
  		if(Rt[1] == 't')releaseRegister(Rt);
  		fclose(MIPS_FILE);
  		Stack.push(Rd1);
        }        
		| expr TOKEN_NOTEQUAL expr //* EXPR != EXPR
		{
		struct ExprStruct* pnt = new ExprStruct();
		if((($1)->expr_type =="int" && ($3)->expr_type =="int")){
			pnt->expr_type ="boolean";
			pnt->expr_val_bool = ($1)->expr_val_int != ($3)->expr_val_int ? true : false;		
			$$ = pnt;	
		}else if((($1)->expr_type =="boolean" && ($3)->expr_type =="boolean")){
			pnt->expr_type ="boolean";
			pnt->expr_val_bool = ($1)->expr_val_bool != ($3)->expr_val_bool ? true : false;			
			$$ = pnt;
		}else{
          yyerror("Operands of != Operation should have INTEGER or BOOLEAN  type");
		}
		//*Code Generation
        MIPS_FILE = fopen("MIPS.asm", "a+");        
  		string Rt = Stack.top();
        Stack.pop();
  		string Rs = Stack.top();
        Stack.pop();
        string Rd1 = getNewRegister('t');
        string Rd2 = getNewRegister('t');
  		if(Rs[0]!='$' && Rt[0]!='$')
  			fprintf(MIPS_FILE,"\taddi %s,$zero,%d\n", Rd1.c_str(),convertStringToInt(Rs)!=convertStringToInt(Rt));
  		else if(Rs[0]!='$'){
          	fprintf(MIPS_FILE,"\taddi %s,$zero,%s\n", Rd1.c_str(), Rs.c_str());
  			fprintf(MIPS_FILE,"\tslt %s,%s,%s\n", Rd1.c_str(), Rd1.c_str(), Rt.c_str());
         	fprintf(MIPS_FILE,"\tslti %s,%s,%s\n", Rd2.c_str(), Rt.c_str(), Rs.c_str());
  			fprintf(MIPS_FILE,"\tor %s,%s,%s\n", Rd1.c_str(), Rd1.c_str(), Rd2.c_str());
        }
        else if(Rt[0]!='$'){
          fprintf(MIPS_FILE,"\taddi %s,$zero,%s\n", Rd2.c_str(), Rt.c_str());
  		  fprintf(MIPS_FILE,"\tslt %s,%s,%s\n", Rd2.c_str(), Rd2.c_str(), Rs.c_str());
  		  fprintf(MIPS_FILE,"\tslti %s,%s,%s\n", Rd1.c_str(), Rs.c_str(), Rt.c_str());
  		  fprintf(MIPS_FILE,"\tor %s,%s,%s\n", Rd1.c_str(), Rd1.c_str(), Rd2.c_str());
        }
  		else{
  			fprintf(MIPS_FILE,"\tslt %s,%s,%s\n", Rd1.c_str(), Rs.c_str(), Rt.c_str());
  			fprintf(MIPS_FILE,"\tslt %s,%s,%s\n", Rd2.c_str(), Rt.c_str(), Rs.c_str());
  			fprintf(MIPS_FILE,"\tor %s,%s,%s\n", Rd1.c_str(), Rd1.c_str(), Rd2.c_str());
  		}
        releaseRegister(Rd2);
        if(Rs[1] == 't') releaseRegister(Rs);			
  		if(Rt[1] == 't') releaseRegister(Rt);		
  		fclose(MIPS_FILE);
  		Stack.push(Rd1);		
        }
	| expr TOKEN_PLUS expr //* EXPR+EXPR
		{			
		struct ExprStruct* pnt = new ExprStruct();
		if(($1)->expr_type !="int" || ($3)->expr_type !="int")
          yyerror("Operands of Plus Operation should have int type");
		pnt->expr_type ="int";
		pnt->expr_val_int =($1)->expr_val_int+($3)->expr_val_int;
		$$ = pnt;
		//*Code Generation
        MIPS_FILE = fopen("MIPS.asm", "a+");
  		string Rt = Stack.top();		  
        Stack.pop();
  		string Rs = Stack.top();		  
        Stack.pop();
        string Rd = getNewRegister('t');
  		if(Rs[0]!='$' && Rt[0]!='$')
  			fprintf(MIPS_FILE,"\taddi %s,$zero,%d\n", Rd.c_str(),convertStringToInt(Rs)+convertStringToInt(Rt));
  		else if(Rs[0]!='$')
          	fprintf(MIPS_FILE,"\taddi %s,%s,%s\n", Rd.c_str(), Rt.c_str(), Rs.c_str());
        else if(Rt[0]!='$')
         	fprintf(MIPS_FILE,"\taddi %s,%s,%s\n", Rd.c_str(), Rs.c_str(), Rt.c_str());
  		else
          	fprintf(MIPS_FILE,"\tadd %s,%s,%s\n", Rd.c_str(), Rs.c_str(), Rt.c_str());
        if(Rs[1] == 't')
  			releaseRegister(Rs);
  		if(Rt[1] == 't')
  			releaseRegister(Rt);
  		fclose(MIPS_FILE);
  		Stack.push(Rd);
        }
	| expr TOKEN_MINUS expr //* EXPR-EXPR
		{
		struct ExprStruct* pnt = new ExprStruct();		
		if(($1)->expr_type !="int" || ($3)->expr_type !="int")
          yyerror("Operands of Minus Operation should have int type");
		pnt->expr_type ="int";
		pnt->expr_val_int =($1)->expr_val_int-($3)->expr_val_int;
		$$ = pnt;
		//*Code Generation
        MIPS_FILE = fopen("MIPS.asm", "a+");
  		string Rt = Stack.top();
        Stack.pop();
  		string Rs = Stack.top();
        Stack.pop();
        string Rd = getNewRegister('t');
  		if(Rs[0]!='$' && Rt[0]!='$')
  		  fprintf(MIPS_FILE,"\taddi %s,$zero,%d\n", Rd.c_str(),convertStringToInt(Rs)-convertStringToInt(Rt));
  		else if(Rs[0]!='$'){
          fprintf(MIPS_FILE,"\tsub %s,$zero,%s", Rd.c_str(),Rt.c_str());
          fprintf(MIPS_FILE,"\taddi %s,%s,%s\n", Rd.c_str(), Rd.c_str(), Rs.c_str());
        }
        else if(Rt[0]!='$')
          fprintf(MIPS_FILE,"\taddi %s,%s,-%s\n", Rd.c_str(), Rs.c_str(), Rt.c_str());
  		else
          fprintf(MIPS_FILE,"\tsub %s,%s,%s\n", Rd.c_str(), Rs.c_str(), Rt.c_str());
        if(Rs[1] == 't') releaseRegister(Rs);
  		if(Rt[1] == 't') releaseRegister(Rt);
  		fclose(MIPS_FILE);
  		Stack.push(Rd);
        }
	| expr TOKEN_DIVISION expr //* EXPR/EXPR
		{
		struct ExprStruct* pnt = new ExprStruct();
		if(($1)->expr_type !="int" || ($3)->expr_type !="int")
          yyerror("Operands of Division Operation should have int type");
		if(($3)->expr_val_int == 0){
			cout<<"\nWARNING: YOU CANNOT DIVIDE NUMBERS BY ZERO!\n";
		}
		pnt->expr_type ="int";
		pnt->expr_val_int =($1)->expr_val_int / ($3)->expr_val_int;
		$$ = pnt;
		//*Code Generation
        MIPS_FILE = fopen("MIPS.asm", "a+");        
  		string Rt = Stack.top();
        Stack.pop();
  		string Rs = Stack.top();
        Stack.pop();
        string Rd = getNewRegister('t');
         if(($3)->expr_val_int == 0 || Rs[1]=='s' || Rt[1]=='s') cout<<"divide by zero on line "<<numLines<<endl;
  		if(Rs[0]!='$' && Rt[0]!='$')
  			fprintf(MIPS_FILE,"\taddi %s,$zero,%d\n", Rd.c_str(),convertStringToInt(Rs)/convertStringToInt(Rt));
  		else if(Rs[0]!='$'){
          fprintf(MIPS_FILE,"\taddi %s,$zero,%s", Rd.c_str(),Rs.c_str());
          fprintf(MIPS_FILE,"\tdiv %s,%s,%s\n", Rd.c_str(), Rd.c_str(), Rt.c_str());
        }
        else if(Rt[0]!='$'){
          fprintf(MIPS_FILE,"\taddi %s,$zero,%s", Rd.c_str(),Rt.c_str());
          fprintf(MIPS_FILE,"\tdiv %s,%s,%s\n", Rd.c_str(), Rs.c_str(), Rt.c_str());
        }
  		else 
		  fprintf(MIPS_FILE,"\tdiv %s,%s,%s\n", Rd.c_str(), Rs.c_str(), Rt.c_str());
        if(Rs[1] == 't') releaseRegister(Rs);
  		if(Rt[1] == 't') releaseRegister(Rt);
  		fclose(MIPS_FILE);
  		Stack.push(Rd);
		
        }
	| expr TOKEN_MODULO expr //* EXPR % EXPR
		{
		struct ExprStruct* pnt = new ExprStruct();	
		if(($1)->expr_type !="int" || ($3)->expr_type !="int")
          yyerror("Operands of Modulo Operation should have int type");
		pnt->expr_type ="int";
		pnt->expr_val_int =($1)->expr_val_int % ($3)->expr_val_int;
		$$ = pnt;
		MIPS_FILE = fopen("MIPS.asm", "a+");        
  		string Rt = Stack.top();
      	Stack.pop();
  		string Rs = Stack.top();
      	Stack.pop();
      	string Rd = getNewRegister('t');
      	fprintf(MIPS_FILE,"\taddi %s,$zero,%s", Rd.c_str(),convertToString(pnt->expr_val_int));


      if(Rs[1] == 't') releaseRegister(Rs);
  		if(Rt[1] == 't') releaseRegister(Rt);
  		fclose(MIPS_FILE);
  		Stack.push(Rd);
        }
	| expr TOKEN_MULTIPLICATION expr //* EXPR * EXPR
		{
		struct ExprStruct* pnt = new ExprStruct();		
		if(($1)->expr_type !="int" || ($3)->expr_type !="int")
          yyerror("Operands of Multiplication Operation should have int type");
		pnt->expr_type ="int";
		pnt->expr_val_int =($1)->expr_val_int * ($3)->expr_val_int;
		$$ = pnt;
		//*Code Generation
        MIPS_FILE = fopen("MIPS.asm", "a+");        
  		string Rt = Stack.top();
        Stack.pop();
  		string Rs = Stack.top();
        Stack.pop();
        string Rd = getNewRegister('t');
  		if(Rs[0]!='$' && Rt[0]!='$')
  			fprintf(MIPS_FILE,"\taddi %s,$zero,%d\n", Rd.c_str(),convertStringToInt(Rs)*convertStringToInt(Rt));
  		else if(Rs[0]!='$'){
          fprintf(MIPS_FILE,"\taddi %s,$zero,%s", Rd.c_str(),Rs.c_str());
          fprintf(MIPS_FILE,"\tmul %s,%s,%s\n", Rd.c_str(), Rd.c_str(), Rt.c_str());
        }
        else if(Rt[0]!='$'){
          fprintf(MIPS_FILE,"\taddi %s,$zero,%s", Rd.c_str(),Rt.c_str());
          fprintf(MIPS_FILE,"\tmul %s,%s,%s\n", Rd.c_str(), Rs.c_str(), Rt.c_str());
        }
  		else
          fprintf(MIPS_FILE,"\tmul %s,%s,%s\n", Rd.c_str(), Rs.c_str(), Rt.c_str());
        if(Rs[1] == 't') releaseRegister(Rs);
  		if(Rt[1] == 't') releaseRegister(Rt);
  		fclose(MIPS_FILE);
  		Stack.push(Rd);
        }
	| expr TOKEN_OR expr //* EXPR|| EXPR
		{
		struct ExprStruct* pnt = new ExprStruct();		
		if(($1)->expr_type !="boolean" || ($3)->expr_type !="boolean")
          yyerror("Operands of OR Operation should have boolean type");
		pnt->expr_type ="boolean";
		pnt->expr_val_bool =($1)->expr_val_bool || ($3)->expr_val_bool;
		$$ = pnt;
		//*Code Generation
        MIPS_FILE = fopen("MIPS.asm", "a+");       
  		string Rt = Stack.top();
        Stack.pop();
  		string Rs = Stack.top();
        Stack.pop();
        string Rd1 = getNewRegister('t');
        string Rd2 = getNewRegister('t');
  		if(Rs[0]!='$' && Rt[0]!='$')
  			fprintf(MIPS_FILE,"\taddi %s,$zero,%d\n", Rd1.c_str(),convertStringToInt(Rs)||convertStringToInt(Rt));
  		else if(Rs[0]!='$'){
          	fprintf(MIPS_FILE,"\tslti %s,$zero,%s\n", Rd1.c_str(), Rs.c_str());
  			fprintf(MIPS_FILE,"\taddi %s,$zero,%s\n", Rd2.c_str(), Rs.c_str());
  			fprintf(MIPS_FILE,"\tslt %s,%s,$zero\n", Rd2.c_str(), Rd2.c_str());
  			fprintf(MIPS_FILE,"\tor %s,%s,%s\n", Rd1.c_str(), Rd1.c_str(), Rd2.c_str());
  			Label++;
          	fprintf(MIPS_FILE,"\taddi %s,$zero,1\n", Rd2.c_str());
  			fprintf(MIPS_FILE,"\tbeq %s,%s L%d\n", Rd2.c_str(), Rd1.c_str(), Label);
  			fprintf(MIPS_FILE,"\tslt %s,$zero %s\n", Rd1.c_str(), Rt.c_str());
  			fprintf(MIPS_FILE,"\tslt %s,%s,$ero\n", Rd2.c_str(), Rt.c_str());
  			fprintf(MIPS_FILE,"\tor %s,%s,%s\n", Rd1.c_str(), Rd1.c_str(), Rd2.c_str());
  			fprintf(MIPS_FILE,"\tL%d:\n", Label);
        }
        else if(Rt[0]!='$'){
            fprintf(MIPS_FILE,"\tslt %s,$zero,%s\n", Rd1.c_str(), Rs.c_str());
  			fprintf(MIPS_FILE,"\tslt %s,%s,$zero\n", Rd2.c_str(), Rs.c_str());
  			fprintf(MIPS_FILE,"\tor %s,%s,%s\n", Rd1.c_str(), Rd1.c_str(), Rd2.c_str());
  			Label++;
         	fprintf(MIPS_FILE,"\taddi %s,$zero,1\n",Rd2.c_str());
  			fprintf(MIPS_FILE,"\tbeq %s,%s,L%d\n", Rd2.c_str(), Rd1.c_str(), Label);
  			fprintf(MIPS_FILE,"\tslti %s,$zero,%s\n", Rd1.c_str(), Rt.c_str());
  			fprintf(MIPS_FILE,"\taddi %s,$zero,%s\n", Rd2.c_str(), Rt.c_str());
  			fprintf(MIPS_FILE,"\tslt %s,%s,$zero\n", Rd2.c_str(), Rd2.c_str());
  			fprintf(MIPS_FILE,"\tor %s,%s,%s\n", Rd1.c_str(), Rd1.c_str(), Rd2.c_str());
  			fprintf(MIPS_FILE,"\tL%d:\n",Label);
        }
  		else{
          	fprintf(MIPS_FILE,"\tslt %s,$zero,%s\n", Rd1.c_str(), Rs.c_str());
  		  	fprintf(MIPS_FILE,"\tslt %s,%s,$zero \n", Rd2.c_str(), Rs.c_str());
  		  	fprintf(MIPS_FILE,"\tor %s,%s,%s\n", Rd1.c_str(), Rd1.c_str(), Rd2.c_str());
  		  	Label++;
            fprintf(MIPS_FILE,"\taddi %s,$zero,1\n", Rd2.c_str());
  			fprintf(MIPS_FILE,"\tbeq %s,%s,L%d\n", Rd2.c_str(), Rd1.c_str(), Label);
  			fprintf(MIPS_FILE,"\tslt %s,$zero,%s\n", Rd1.c_str(), Rt.c_str());
  			fprintf(MIPS_FILE,"\tslt %s,%s,$zero\n", Rd2.c_str(), Rt.c_str());
  			fprintf(MIPS_FILE,"\tor %s,%s,%s\n", Rd1.c_str(), Rd1.c_str(), Rd2.c_str());
  			fprintf(MIPS_FILE,"\tL%d:\n", Label);
        }
        releaseRegister(Rd2);
        if(Rs[1] == 't') releaseRegister(Rs);
  		if(Rt[1] == 't') releaseRegister(Rt);
  		fclose(MIPS_FILE);
  		Stack.push(Rd1);
        }    
	| expr TOKEN_AND expr //* EXPR && EXPR
		{
		struct ExprStruct* pnt = new ExprStruct();		
		if(($1)->expr_type !="boolean" || ($3)->expr_type !="boolean")
          yyerror("Operands of AND Operation should have boolean type");
		pnt->expr_type ="boolean";
		pnt->expr_val_bool =($1)->expr_val_bool && ($3)->expr_val_bool;
		$$ = pnt;

		//*Code Generation
        MIPS_FILE = fopen("MIPS.asm", "a+");        
  		string Rt = Stack.top();
        Stack.pop();
  		string Rs = Stack.top();
        Stack.pop();
        string Rd1 = getNewRegister('t');
        string Rd2 = getNewRegister('t');
  		if(Rs[0]!='$' && Rt[0]!='$')
  			fprintf(MIPS_FILE,"\taddi %s,$zero,%d\n", Rd1.c_str(),convertStringToInt(Rs)&&convertStringToInt(Rt));
  		else if(Rs[0]!='$'){
            fprintf(MIPS_FILE,"\tslti %s,$zero,%s\n", Rd1.c_str(), Rs.c_str());
  			fprintf(MIPS_FILE,"\taddi %s,$zero,%s\n", Rd2.c_str(), Rs.c_str());
  			fprintf(MIPS_FILE,"\tslt %s,%s,$zero\n", Rd2.c_str(), Rd2.c_str());
  			fprintf(MIPS_FILE,"\tor %s,%s,%s\n", Rd1.c_str(), Rd1.c_str(), Rd2.c_str());
  			Label++;
  			fprintf(MIPS_FILE,"\tbeq %s,$zero L%d\n", Rd1.c_str(), Label);
  			fprintf(MIPS_FILE,"\tslt %s,$zero %s\n", Rd1.c_str(), Rt.c_str());
  			fprintf(MIPS_FILE,"\tslt %s,%s,$ero\n", Rd2.c_str(), Rt.c_str());
  			fprintf(MIPS_FILE,"\tor %s,%s,%s\n", Rd1.c_str(), Rd1.c_str(), Rd2.c_str());
  			fprintf(MIPS_FILE,"\tL%d:\n", Label);
        }
        else if(Rt[0]!='$'){
        	fprintf(MIPS_FILE,"\tslt %s,$zero,%s\n", Rd1.c_str(), Rs.c_str());
  			fprintf(MIPS_FILE,"\tslt %s,%s,$zero\n", Rd2.c_str(), Rs.c_str());
  			fprintf(MIPS_FILE,"\tor %s,%s,%s\n", Rd1.c_str(), Rd1.c_str(), Rd2.c_str());
  			Label++;
  			fprintf(MIPS_FILE,"\tbeq %s,$zero,L%d\n", Rd1.c_str(), Label);
  			fprintf(MIPS_FILE,"\tslti %s,$zero,%s\n", Rd1.c_str(), Rt.c_str());
  			fprintf(MIPS_FILE,"\taddi %s,$zero,%s\n", Rd2.c_str(), Rt.c_str());
  			fprintf(MIPS_FILE,"\tslt %s,%s,$zero\n", Rd2.c_str(), Rd2.c_str());
  			fprintf(MIPS_FILE,"\tor %s,%s,%s\n", Rd1.c_str(), Rd1.c_str(), Rd2.c_str());
  			fprintf(MIPS_FILE,"\tL%d:\n",Label);
        }
  		else{
          	fprintf(MIPS_FILE,"\tslt %s,$zero,%s\n", Rd1.c_str(), Rs.c_str());
  			fprintf(MIPS_FILE,"\tslt %s,%s,$zero \n", Rd1.c_str(), Rs.c_str());
  			fprintf(MIPS_FILE,"\tor %s,%s,%s\n", Rd1.c_str(), Rd1.c_str(), Rd1.c_str());
  			Label++;
  			fprintf(MIPS_FILE,"\tbeq %s,$zero,L%d\n", Rd1.c_str(), Label);
  			fprintf(MIPS_FILE,"\tslt %s,$zero,%s\n", Rd1.c_str(), Rt.c_str());
  			fprintf(MIPS_FILE,"\tslt %s,%s,$zero\n", Rd1.c_str(), Rt.c_str());
  			fprintf(MIPS_FILE,"\tor %s,%s,%s\n", Rd1.c_str(), Rd1.c_str(), Rd2.c_str());
  			fprintf(MIPS_FILE,"\tL%d:\n", Label);
        }
        releaseRegister(Rd2);
        if(Rs[1] == 't')releaseRegister(Rs);
  		if(Rt[1] == 't')releaseRegister(Rt);
  		fclose(MIPS_FILE);
  		Stack.push(Rd1);		
        }
	| TOKEN_MINUS expr //* -EXPR
	{
		struct ExprStruct* pnt = new ExprStruct();
		if (($2)->expr_type!= "int") yyerror("Operand of MINUS Operation should have INTEGER type");
		pnt->expr_type ="int";
		pnt->expr_val_int = -($2)->expr_val_int;
		$$ = pnt;

		//*Code Generation
  		string Rs = Stack.top();
        Stack.pop();
        if(Rs[0]!='$')
          Stack.push("-"+convertToString($2-> expr_val_int));
  		else{
  		  	string Rd = getNewRegister('t');
  		  	MIPS_FILE = fopen("MIPS.asm", "a+");
  		  	fprintf(MIPS_FILE,"\tsub %s,$zero,%s\n", Rd.c_str(), Rs.c_str());
          	fclose(MIPS_FILE);
    		Stack.push(Rd);
  			}
	}
	| TOKEN_LOGICOP expr { //* !EXPR
		struct ExprStruct* pnt = new ExprStruct();			
		if(($2)->expr_type !="boolean")
          yyerror("Error: type of expression in not Operation should be boolean");
		pnt->expr_type ="boolean";
		pnt->expr_val_bool =($2)->expr_val_bool ==true ? false : true;
		$$ = pnt;
		//*Code Generation        
  		string Rs = Stack.top();
        Stack.pop();
        if(Rs[0]!='$'){
  			if(Rs[0] == 0) Stack.push("1");
  			else Stack.push("0");
        }
        else{
          string Rd1 = getNewRegister('t');
          string Rd2 = getNewRegister('t');
  		  MIPS_FILE = fopen("MIPS.asm", "a+");
  		  fprintf(MIPS_FILE,"\tslt %s,$zero,%s\n", Rd1.c_str(), Rs.c_str());
  		  fprintf(MIPS_FILE,"\tslt %s,%s,$zero\n", Rd2.c_str(), Rs.c_str());
  		  fprintf(MIPS_FILE,"\tor %s,%s,%s\n", Rd1.c_str(), Rd1.c_str(), Rd2.c_str());
  		  fprintf(MIPS_FILE,"\txori %s,%s,1\n", Rd1.c_str(), Rd1.c_str());
  		  releaseRegister(Rd2);
  		  if(Rs[1] == 't') 	releaseRegister(Rs);
          fclose(MIPS_FILE);
    	  Stack.push(Rd1);
  		}
	}
	| TOKEN_LP expr TOKEN_RP //* (EXPR)
	{  
		struct ExprStruct* pnt = new ExprStruct(); 
		pnt->expr_type = ($2)->expr_type;
		if(pnt->expr_type == "int"){
			pnt->expr_val_int = ($2)->expr_val_int;
		}else if(pnt->expr_type == "boolean"){
			pnt->expr_val_bool = ($2)->expr_val_bool;
		}else if(pnt->expr_type == "char"){
			pnt->expr_val_char = ($2)->expr_val_char;
		}
		$$ = pnt;
	};

stmt_if : TOKEN_IFCONDITION {currentScope=currentScope+" "+"if";} TOKEN_LP expr
		 {			
			 if(($4)->expr_type!="boolean"){
				 yyerror("Error: type of expression in IF statment should be boolean");
			 }
			//*Code Generation
              string Rd = Stack.top();
              Stack.pop();
              Label++;
              MIPS_FILE = fopen("MIPS.asm", "a+");
        	  fprintf(MIPS_FILE,"\tbeq %s,$zero,L%d\n", Rd.c_str(), Label);
              fclose(MIPS_FILE);
		 } TOKEN_RP block 
		 {
			currentScope.erase(currentScope.size()-(strlen("if")+1),strlen("if")+1);
		 	currentScope=currentScope+" "+"else";
		}optional_else;		  

optional_else: TOKEN_ELSECONDITION block 
		{
          Label++;
          MIPS_FILE = fopen("MIPS.asm", "a+");
          fprintf(MIPS_FILE,"\tj L%d\n", Label);
          fprintf(MIPS_FILE,"\tL%d:\n", Label-1);
          fclose(MIPS_FILE);
		}
		| /* empty */ ;

stmt_for : TOKEN_LOOP {currentScope=currentScope+" "+"for";} TOKEN_ID TOKEN_ASSIGNOP
		expr
		{
			if(($5)->expr_type !="int") yyerror("type of START counter of FOR LOOP should be INTEGER");
		}
		TOKEN_COMMA expr
		{
		if(($8)->expr_type !="int") yyerror("type of END counter of FOR LOOP should be INTEGER");	
		//!RISK
		pushSymbol($3,currentScope,getNewRegister('s'),"int",false,0);	
		string Rt = Stack.top();		
         Stack.pop();
         string Rs = Stack.top();		 
         Stack.pop();
         MIPS_FILE = fopen("MIPS.asm", "a+"); 
		fprintf(MIPS_FILE,"\taddi %s,$zero,%s\n", (getSymbol($3,currentScope)->reg).c_str(), Rs.c_str());		
		 cout<<"what?\n";
		 //!CHECK
		// if(Rs[0]!= '$'){
        //  	fprintf(MIPS_FILE,"\taddi %s,$zero,%s\n", (getSymbol($3,currentScope)->reg).c_str(), Rs.c_str());
        // }
        // else{
        //     fprintf(MIPS_FILE,"\tmove %s,%s\n", (getSymbol($3,currentScope)->reg).c_str(), Rs.c_str());
        // }
         forLabel++;
         fprintf(MIPS_FILE,"LOOP%d:\n", forLabel);
         string Rd = getNewRegister('t');
		 cout<<"\nRd\n";
         fprintf(MIPS_FILE,"\taddi %s,$zero,%s\n", Rd.c_str(), Rt.c_str());
         fprintf(MIPS_FILE,"\tslt %s,%s,%s\n", Rd.c_str(), Rd.c_str(), (getSymbol($3,currentScope)->reg).c_str());		
         fprintf(MIPS_FILE,"\txori %s,%s,1\n", Rd.c_str(), Rd.c_str());
         Label++;
   		fprintf(MIPS_FILE,"\tbeq %s,$zero,L%d\n", Rd.c_str(), Label);
         fclose(MIPS_FILE);
         Stack.push(Rd);
		}
		 block {currentScope.erase(currentScope.size()-(string("for").size()+1),string("for").size()+1);};

stmt_return : TOKEN_RETURN 
			{
				struct Function *func = getFunction(current_func);
				if(func->return_type != "void") yyerror("Error: function *"+ current_func+"* should have a return value!"); //*CHECK FOR EQUAL TYPES
			}
			|TOKEN_RETURN expr
			{				
				struct Function *func = getFunction(current_func);
 				if(func->return_type != ($2)->expr_type) yyerror("Error: return type does not match with declaration!"); //*CHECK FOR EQUAL TYPES
				if(func->return_type !="int" && func->return_type !="boolean") yyerror("Error: return type should be *boolean* or *int*"); //*CHECK FOR INT,BOOL
			};

callout_arg : expr | TOKEN_STRINGCONST;
%%

int main (int argc, char *argv[]){
	int flag;
	yyin = fopen(argv[1], "r");
	if(yyin == 0){
	cout << "Unable to open the file" << endl;
    return 0;
	}
	/*.asm File*/
  	MIPS_FILE = fopen("MIPS.asm", "w");
	if(MIPS_FILE == 0){
    cout << "Unable to create the output file" << endl;
    return 0;
	}
	else{
		fprintf(MIPS_FILE,".data\n\tbackn: .asciiz \"\\n\" \n.text\n.globl main\n");
		fclose(MIPS_FILE);
	}
	flag = yyparse();
	fclose(yyin);
	cout<<"\nParsing finished!\n";
	return flag;
}

void yyerror(string error_message){
  cout<<"\nparser gave error\n"<<error_message<<" \nError at line "<<numLines<<endl;
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


//*Code Generation Section
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
	char y[12];
	sprintf(y,"%d",i);	
	string ans(y);	
	return ans;
}

int convertStringToInt(string str)
{
	stringstream res(str);
	int x = 0;
	res >> x;
	return x;
}
