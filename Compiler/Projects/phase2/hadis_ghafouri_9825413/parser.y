%{
	#include <iostream>
	#include <stdlib.h>
	#include <string.h>
	#include <math.h>
	using namespace std;		

	extern int yylex();
	extern int numLines;
	extern FILE * yyin;
	extern FILE *yyout;    
    bool printByTokenName;
    string output = "\n";
    int num_nodes =0;

  typedef struct Node {
        char valname[100];		
        char token[100];
		char type[100];		
		bool isshow;
		bool lastchild;
		struct Node *child;
        struct Node *ptr;
    }Node;

    /*********functions***********/
	Node* CreateNode();
	Node* ProgramNode(Node*, Node*);
	Node* ProgramNode(string, string, Node*);
	void PreOrderTraversal(Node*);
    void printTree(Node*);
    void print(Node*);
    void yyerror(const char*);
	/********* Root Node in Tree ***********/	
	Node *Root=NULL;
%}

%union{
	char* string;
	struct Node* node;	
}

/************TOKENS************/
%token<string> TOKEN_ID
%token<string> TOKEN_DECIMALCONST
%token<string> TOKEN_CHARCONST
%token<string> TOKEN_HEXADECIMALCONST  
%token<string> TOKEN_STRINGCONST   
%token<string> TOKEN_BOOLEANCONST 
%token<string> 	TOKEN_PROGRAMCLASS TOKEN_MAINFUNC TOKEN_BREAKSTMT TOKEN_CALLOUT TOKEN_CLASS TOKEN_CONTINUESTMT TOKEN_VOIDTYPE TOKEN_BOOLEANTYPE;
%token<string>	TOKEN_INTTYPE  TOKEN_IFCONDITION TOKEN_ELSECONDITION TOKEN_LOOP TOKEN_RETURN TOKEN_LP TOKEN_RP TOKEN_LCB TOKEN_RCB TOKEN_LB TOKEN_RB;
%token<string>	TOKEN_SEMICOLON TOKEN_COMMA TOKEN_LOGICOP TOKEN_EQUALITYOP TOKEN_AND TOKEN_OR TOKEN_ASSIGNOP TOKEN_PLUS TOKEN_MINUS TOKEN_MULTIPLICATION;
%token<string>	TOKEN_DIVISION
%token<string>	TOKEN_MODULO
%token<string>	TOKEN_RELATIONOP



/************Priority************/
%right TOKEN_ASSIGNOP
%left TOKEN_OR
%left TOKEN_AND
%left TOKEN_EQUALITYOP
%left TOKEN_RELATIONOP
%left TOKEN_PLUS TOKEN_MINUS
%left TOKEN_MULTIPLICATION TOKEN_DIVISION TOKEN_MODULO
%right TOKEN_LOGICOP  
%left TOKEN_LB TOKEN_RB
%left TOKEN_LP TOKEN_RP

 /********NON-TERMINALS*********/
%type <node> program
%type <node> decl_fields
%type <node> decl_field
%type <node> decl_methods
%type <node> decl_method
%type <node> method_id
%type <node> block
%type <node> declare_vars
%type <node> declare_var
%type <node> names
%type <node> ids
%type <node> type
%type <node> statments
%type <node> statment
%type <node> method_call
%type <node> call_params
%type <node> method_args
%type <node> method_arg
%type <node> optional_callout_args
%type <node> callout_args
%type <node> location
%type <node> expr
%type <node> stmt_if
%type <node> optional_else
%type <node> stmt_for
%type <node> stmt_return
%type <node> callout_arg
%type <node> literal

%start program

%%
program : TOKEN_CLASS  TOKEN_PROGRAMCLASS TOKEN_LCB  decl_fields  decl_methods  TOKEN_RCB     
        {
			Node *a = CreateNode();
            strcpy(a->token,"program");
            Root = a;
            a=ProgramNode($1,"TOKEN_CLASS",a);
            a=ProgramNode($2,"TOKEN_PROGRAMCLASS",a);
            a=ProgramNode($3,"TOKEN_LCB",a);
            a=ProgramNode($4,a);
            a=ProgramNode($5,a);
            a=ProgramNode($6,"TOKEN_RCB",a);
            $$ = a;
        };

decl_fields :decl_fields decl_field 
            {
            	Node *a = CreateNode();
                strcpy(a->token,"decl_fields");
                a=ProgramNode($1,a);
                a=ProgramNode($2,a);
                $$ = a;
            }|/*empty*/ 
            {
                Node *b = CreateNode();
                strcpy(b->token,"decl_fields");
                b->isshow = 0;
                $$ = b;
            };

decl_field : type names TOKEN_SEMICOLON			
        {
			Node *a = CreateNode();
            strcpy(a->token,"decl_field");
            a=ProgramNode($1,a);
            a=ProgramNode($2,a);
            a=ProgramNode($3,"TOKEN_SEMICOLON",a);
            $$ = a;
		};

names: names TOKEN_COMMA location		
			{
				Node *a = CreateNode();
                strcpy(a->token,"names");
                a=ProgramNode($1,a);
                a=ProgramNode($2,"TOKEN_COMMA",a);
                a=ProgramNode($3,a);
                $$ = a;

			}
			| location
			{
				Node *b = CreateNode();
                strcpy(b->token,"names");
                b=ProgramNode($1,b);
                $$ = b;
			};

decl_methods : decl_method decl_methods
            {
				Node *b = CreateNode();
                strcpy(b->token,"decl_methods");
                b=ProgramNode($1,b);
                b=ProgramNode($2,b);
                $$ = b;
            }
            |/*empty*/ 
            {
                Node *a = CreateNode();
                strcpy(a->token,"decl_methods");
                a->isshow = 0;
                $$ = a;
            };
decl_method : TOKEN_VOIDTYPE method_id TOKEN_LP method_args  TOKEN_RP  block
			{
				Node *a = CreateNode();
                strcpy(a->token,"decl_method");
                a=ProgramNode($1,"TOKEN_VOIDTYPE",a);
                a=ProgramNode($2,a);
                a=ProgramNode($3,"TOKEN_LP",a);
                a=ProgramNode($4,a);
                a=ProgramNode($5,"TOKEN_RP",a);
                a=ProgramNode($6,a);
                $$ = a;
			}
			|type  method_id TOKEN_LP method_args TOKEN_RP  block
			{
				Node *a = CreateNode();
                strcpy(a->token,"decl_method");
                a=ProgramNode($1,a);
                a=ProgramNode($2,a);
                a=ProgramNode($3,"TOKEN_LP",a);
                a=ProgramNode($4,a);
                a=ProgramNode($5,"TOKEN_RP",a);
                a=ProgramNode($6,a);
                $$ = a;
			};

method_id : TOKEN_ID			
        {
			Node *a = CreateNode();
            strcpy(a->token,"method_id");
            a=ProgramNode($1,"TOKEN_ID",a);
            $$ = a;
		}
		|TOKEN_MAINFUNC
		{
			Node *b = CreateNode();
            strcpy(b->token,"method_id");
            b=ProgramNode($1,"TOKEN_MAINFUNC",b);
            $$ = b;
		};


block : TOKEN_LCB declare_vars statments TOKEN_RCB
			{
				Node *a = CreateNode();
                strcpy(a->token,"block");
                a=ProgramNode($1,"TOKEN_LCB",a);
                a=ProgramNode($2,a);
                a=ProgramNode($3,a);
                a=ProgramNode($4,"TOKEN_RCB",a);
                $$ = a;
			};

declare_vars :declare_var declare_vars
			{
				Node *a = CreateNode();
                strcpy(a->token,"declare_vars");
                a=ProgramNode($1,a);
                a=ProgramNode($2,a);
                $$ = a;
            }
			|/*empty*/ 
                  {
                  	Node *b = CreateNode();
                  	strcpy(b->token,"declare_vars");
                  	b->isshow = 0;
                  	$$ = b;
                  };

declare_var : type TOKEN_ID ids TOKEN_SEMICOLON
			{
				Node *b = CreateNode();
                strcpy(b->token,"declare_var");
                b=ProgramNode($1,b);
                b=ProgramNode($2,"TOKEN_ID",b);
                b=ProgramNode($3,b);
                b=ProgramNode($4,"TOKEN_SEMICOLON",b);
                $$ = b;
			};

ids :TOKEN_COMMA TOKEN_ID  ids
			{
				Node *a = CreateNode();
                strcpy(a->token,"ids");
                a=ProgramNode($1,"TOKEN_COMMA",a);
                a=ProgramNode($2,"TOKEN_ID",a);
                a=ProgramNode($3,a);
                $$ = a;

			}|/*empty*/ 
                  {
                  	Node *b = CreateNode();
                  	strcpy(b->token,"ids");
                  	b->isshow = 0;
                  	$$ = b;
                  };


type : TOKEN_INTTYPE 
    {
	    Node *a = CreateNode();
        strcpy(a->token,"type");
        a=ProgramNode($1,"TOKEN_INTTYPE",a);
        $$ = a;
    }
	| TOKEN_BOOLEANTYPE
	{
	    Node *a = CreateNode();
        strcpy(a->token,"type");
        a=ProgramNode($1,"TOKEN_BOOLEANTYPE",a);
        $$ = a;
    };

statments :statment statments
			{
				Node *a = CreateNode();
                strcpy(a->token,"statments");
                a=ProgramNode($1,a);
                a=ProgramNode($2,a);
                $$ = a;

			}|/*empty*/ 
                  {
                  	Node *b = CreateNode();
                  	strcpy(b->token,"statments");
                  	b->isshow = 0;
                  	$$ = b;
                  };

statment : location TOKEN_ASSIGNOP expr TOKEN_SEMICOLON
			{
				Node *a = CreateNode();
                strcpy(a->token,"statment");
                a=ProgramNode($1,a);
                a=ProgramNode($2,"TOKEN_ASSIGNOP",a);
                a=ProgramNode($3,a);
                a=ProgramNode($4,"TOKEN_SEMICOLON",a);
                $$ = a;

			}
		| method_call TOKEN_SEMICOLON
			{
				Node *b = CreateNode();
                strcpy(b->token,"statment");
                b=ProgramNode($1,b);
                b=ProgramNode($2,"TOKEN_SEMICOLON",b);
                $$ = b;
			}
		| stmt_if
			{
				Node *c = CreateNode();
                strcpy(c->token,"statment");
                c=ProgramNode($1,c);
                $$ = c;
			}
		| stmt_for
			{
				Node *d = CreateNode();
                strcpy(d->token,"statment");
                d=ProgramNode($1,d);
                $$ = d;
			}
		| stmt_return TOKEN_SEMICOLON
			{
				Node *e = CreateNode();
                strcpy(e->token,"statment");
                e=ProgramNode($1,e);
                e=ProgramNode($2,"TOKEN_SEMICOLON",e);
                $$ = e;
			}
		| TOKEN_BREAKSTMT TOKEN_SEMICOLON
			{
				Node *f = CreateNode();
                strcpy(f->token,"statment");
                f=ProgramNode($1,"TOKEN_BREAKSTMT",f);
                f=ProgramNode($2,"TOKEN_SEMICOLON",f);
                $$ = f;
			}
		| TOKEN_CONTINUESTMT TOKEN_SEMICOLON
			{
				Node *g = CreateNode();
                strcpy(g->token,"statment");
                g=ProgramNode($1,"TOKEN_CONTINUESTMT",g);
                g=ProgramNode($2,"TOKEN_SEMICOLON",g);
                $$ = g;
			}
		| block
			{
				Node *h = CreateNode();
                strcpy(h->token,"statment");
                h=ProgramNode($1,h);
                $$ = h;
			};


method_call : TOKEN_ID TOKEN_LP call_params TOKEN_RP
				{
				Node *e = CreateNode();
                strcpy(e->token,"method_call");
                e=ProgramNode($1,"TOKEN_ID",e);
                e=ProgramNode($2,"TOKEN_LP",e);
                e=ProgramNode($3,e);
                e=ProgramNode($4,"TOKEN_RP",e);
                $$ = e;
				}
			| TOKEN_CALLOUT TOKEN_LP TOKEN_STRINGCONST optional_callout_args TOKEN_RP
			{
				Node *a = CreateNode();
                strcpy(a->token,"method_call");
                a=ProgramNode($1,"TOKEN_CALLOUT",a);
                a=ProgramNode($2,"TOKEN_LP",a);
                a=ProgramNode($3,"TOKEN_STRINGCONST",a);
                a=ProgramNode($4,a);
                a=ProgramNode($5,"TOKEN_RP",a);
                $$ = a;
			};


call_params :/*empty*/ 
                  {
                  	Node *b = CreateNode();
                  	strcpy(b->token,"call_params");
                  	b->isshow = 0;
                  	$$ = b;
                  }
		| expr 
		{
			Node *a = CreateNode();
            strcpy(a->token,"call_params");
            a=ProgramNode($1,a);
            $$ = a;
		}
		| expr TOKEN_COMMA expr 
		{
			Node *a = CreateNode();
            strcpy(a->token,"call_params");
            a=ProgramNode($1,a);
            a=ProgramNode($2,"TOKEN_COMMA",a);
            a=ProgramNode($3,a);
            $$ = a;
		}
		| expr TOKEN_COMMA expr TOKEN_COMMA expr
		{
			Node *a = CreateNode();
            strcpy(a->token,"call_params");
            a=ProgramNode($1,a);
            a=ProgramNode($2,"TOKEN_COMMA",a);
            a=ProgramNode($3,a);
            a=ProgramNode($4,"TOKEN_COMMA",a);
            a=ProgramNode($5,a);
            $$ = a;
		}
		| expr TOKEN_COMMA expr TOKEN_COMMA expr TOKEN_COMMA expr
		{
			Node *a = CreateNode();
            strcpy(a->token,"call_params");
            a=ProgramNode($1,a);
            a=ProgramNode($2,"TOKEN_COMMA",a);
            a=ProgramNode($3,a);
            a=ProgramNode($4,"TOKEN_COMMA",a);
            a=ProgramNode($5,a);
            a=ProgramNode($6,"TOKEN_COMMA",a);
            a=ProgramNode($7,a);
            $$ = a;
		};

method_args :
		method_arg TOKEN_COMMA method_arg TOKEN_COMMA method_arg TOKEN_COMMA method_arg
		{
			Node *a = CreateNode();
            strcpy(a->token,"method_args");
            a=ProgramNode($1,a);
            a=ProgramNode($2,"TOKEN_COMMA",a);
            a=ProgramNode($3,a);
            a=ProgramNode($4,"TOKEN_COMMA",a);
            a=ProgramNode($5,a);
            a=ProgramNode($6,"TOKEN_COMMA",a);
            a=ProgramNode($7,a);
            $$ = a;
		}
		| method_arg TOKEN_COMMA method_arg TOKEN_COMMA method_arg
		{
			Node *a = CreateNode();
            strcpy(a->token,"method_args");
            a=ProgramNode($1,a);
            a=ProgramNode($2,"TOKEN_COMMA",a);
            a=ProgramNode($3,a);
            a=ProgramNode($4,"TOKEN_COMMA",a);
            a=ProgramNode($5,a); 
            $$ = a;
		}
		| method_arg  TOKEN_COMMA method_arg 
		{
			Node *a = CreateNode();
            strcpy(a->token,"method_args");
            a=ProgramNode($1,a);
            a=ProgramNode($2,"TOKEN_COMMA",a);
            a=ProgramNode($3,a);
            $$ = a;
		}
		| method_arg 
		{
			Node *a = CreateNode();
            strcpy(a->token,"method_args");
            a=ProgramNode($1,a);
            $$ = a;
		}
			|/*empty*/ 
                  {
                  	Node *b = CreateNode();
                  	strcpy(b->token,"method_args");
                  	b->isshow = 0;
                  	$$ = b;
                  };

method_arg : type TOKEN_ID
		{
			Node *a = CreateNode();
            strcpy(a->token,"method_arg");
            a=ProgramNode($1,a);
            a=ProgramNode($2,"TOKEN_ID",a);
            $$ = a;
		};

optional_callout_args : /*empty*/{$$ = NULL;}
		| TOKEN_COMMA callout_args
		{
			Node *a = CreateNode();
            strcpy(a->token,"optional_callout_args");
            a=ProgramNode($1,"TOKEN_COMMA",a);
            a=ProgramNode($2,a);
            $$ = a;
		};

callout_args : callout_arg
		{
			Node *a = CreateNode();
            strcpy(a->token,"callout_args");
            a=ProgramNode($1,a);
            $$ = a;
		}
		| callout_arg TOKEN_COMMA callout_args				
		{	
            Node *a = CreateNode();
            strcpy(a->token,"callout_args");
            a=ProgramNode($1,a);
            a=ProgramNode($2,"TOKEN_COMMA",a);
            a=ProgramNode($3,a);
            $$ = a;
		};

location : TOKEN_ID
			{
				Node *a = CreateNode();
                strcpy(a->token,"location");
                a=ProgramNode($1,"TOKEN_ID",a);
                $$ = a;
			}
			| TOKEN_ID TOKEN_LB expr TOKEN_RB
			{
				Node *b = CreateNode();
                strcpy(b->token,"location");
                b=ProgramNode($1,"TOKEN_ID",b);
                b=ProgramNode($2,"TOKEN_LB",b);
                b=ProgramNode($3,b);
                b=ProgramNode($4,"TOKEN_RB",b);
                $$ = b;
			};

expr : location
			{
				Node *b = CreateNode();
                strcpy(b->token,"location");
                b=ProgramNode($1,b);
                $$ = b;
			}
	| method_call
			{
				Node *c = CreateNode();
                strcpy(c->token,"location");
                c=ProgramNode($1,c);
                $$ = c;
			}	
	| literal
			{
				Node *d = CreateNode();
                strcpy(d->token,"location");
                d=ProgramNode($1,d);
                $$ = d;
			}	
	| expr TOKEN_RELATIONOP expr
			{
				Node *e = CreateNode();
                strcpy(e->token,"location");
                e=ProgramNode($1,e);
                e=ProgramNode($2,"TOKEN_RELATIONOP",e);
                e=ProgramNode($3,e);
                $$ = e;
			}

	| expr TOKEN_EQUALITYOP expr
				{
				Node *e = CreateNode();
                strcpy(e->token,"location");
                e=ProgramNode($1,e);
                e=ProgramNode($2,"TOKEN_EQUALITYOP",e);
                e=ProgramNode($3,e);
                $$ = e;
			}
	| expr TOKEN_PLUS expr
				{
				Node *e = CreateNode();
                strcpy(e->token,"location");
                e=ProgramNode($1,e);
                e=ProgramNode($2,"TOKEN_PLUS",e);
                e=ProgramNode($3,e);
                $$ = e;
			}
	| expr TOKEN_MINUS expr
			{
				Node *e = CreateNode();
                strcpy(e->token,"location");
                e=ProgramNode($1,e);
                e=ProgramNode($2,"TOKEN_MINUS",e);
                e=ProgramNode($3,e);
                $$ = e;
			}
	| expr TOKEN_DIVISION expr
			{
				Node *e = CreateNode();
                strcpy(e->token,"location");
                e=ProgramNode($1,e);
                e=ProgramNode($2,"TOKEN_DIVISION",e);
                e=ProgramNode($3,e);
                $$ = e;
			}
	| expr TOKEN_MODULO expr
			{
				Node *e = CreateNode();
                strcpy(e->token,"location");
                e=ProgramNode($1,e);
                e=ProgramNode($2,"TOKEN_MODULO",e);
                e=ProgramNode($3,e);
                $$ = e;
			}
	| expr TOKEN_MULTIPLICATION expr
			{
				Node *e = CreateNode();
                strcpy(e->token,"location");
                e=ProgramNode($1,e);
                e=ProgramNode($2,"TOKEN_MULTIPLICATION",e);
                e=ProgramNode($3,e);
                $$ = e;
			}
	| expr TOKEN_OR expr
				{
				Node *e = CreateNode();
                strcpy(e->token,"location");
                e=ProgramNode($1,e);
                e=ProgramNode($2,"TOKEN_OR",e);
                e=ProgramNode($3,e);
                $$ = e;
			}
	| expr TOKEN_AND expr
				{
				Node *e = CreateNode();
                strcpy(e->token,"location");
                e=ProgramNode($1,e);
                e=ProgramNode($2,"TOKEN_AND",e);
                e=ProgramNode($3,e);
                $$ = e;
			}
	| TOKEN_MINUS expr
				{
				Node *e = CreateNode();
                strcpy(e->token,"location");
                e=ProgramNode($1,"TOKEN_MINUS",e);
                e=ProgramNode($2,e);
                $$ = e;
			}

	|TOKEN_LOGICOP expr 
			{
				Node *g = CreateNode();
                strcpy(g->token,"location");
                g=ProgramNode($1,"TOKEN_LOGICOP",g);
                g=ProgramNode($2,g);
                $$ = g;
			}
	|TOKEN_LP expr TOKEN_RP
			{
				Node *h = CreateNode();
                strcpy(h->token,"location");
                h=ProgramNode($1,"TOKEN_LP",h);
                h=ProgramNode($2,h);
                h=ProgramNode($3,"TOKEN_RP",h);
                $$ = h;
			};

stmt_if : TOKEN_IFCONDITION TOKEN_LP expr TOKEN_RP block optional_else
			{
				Node *a = CreateNode();
                strcpy(a->token,"stmt_if");
                a=ProgramNode($1,"TOKEN_IFCONDITION",a);
                a=ProgramNode($2,"TOKEN_LP",a);
                a=ProgramNode($3,a);
                a=ProgramNode($4,"TOKEN_PR",a);
                a=ProgramNode($5,a);
                a=ProgramNode($6,a);
                $$ = a;

			};

optional_else: TOKEN_ELSECONDITION block 
			{
				Node *a = CreateNode();
                strcpy(a->token,"optional_else");
                a=ProgramNode($1,"TOKEN_ELSECONDITION",a);
                a=ProgramNode($2,a);
                $$ = a;

			}
			|/*empty*/ 
                  {
                  	Node *b = CreateNode();
                  	strcpy(b->token,"optional_else");
                  	b->isshow = 0;
                  	$$ = b;
                  };
stmt_for : TOKEN_LOOP TOKEN_ID TOKEN_ASSIGNOP expr TOKEN_COMMA expr block
			{
				Node *a = CreateNode();
                strcpy(a->token,"stmt_for");
                a=ProgramNode($1,"TOKEN_LOOP",a);
                a=ProgramNode($2,"TOKEN_ID",a);
                a=ProgramNode($3,"TOKEN_ASSIGNOP",a);
                a=ProgramNode($4,a);
                a=ProgramNode($5,"TOKEN_COMMA",a);
                a=ProgramNode($6,a);
                a=ProgramNode($7,a);
                $$ = a;

			};

stmt_return : TOKEN_RETURN 
			{
				Node *a = CreateNode();
                strcpy(a->token,"stmt_return");
                a=ProgramNode($1,"TOKEN_RETURN",a);
                $$ = a;

			}
			|TOKEN_RETURN expr
			{
				Node *b = CreateNode();
                strcpy(b->token,"stmt_return");
                b=ProgramNode($1,"TOKEN_RETURN",b);
                b=ProgramNode($2,b);
                $$ = b;
			};

callout_arg : expr 
					{
							Node *a = CreateNode();
                strcpy(a->token,"callout_arg");
                a=ProgramNode($1,a);
 
                $$ = a;
		}

| TOKEN_STRINGCONST
		{
			Node *a = CreateNode();
            strcpy(a->token,"callout_arg");
            a=ProgramNode($1,"TOKEN_STRINGCONST",a);
            $$ = a;
		};
literal : TOKEN_DECIMALCONST
{
							Node *a = CreateNode();
                strcpy(a->token,"literal");
                a=ProgramNode($1,"TOKEN_DECIMALCONST",a);

                $$ = a;
		}
		 | TOKEN_HEXADECIMALCONST
		 {
							Node *a = CreateNode();
                strcpy(a->token,"literal");
                a=ProgramNode($1,"TOKEN_HEXADECIMALCONST",a);

                $$ = a;
		}
		 | TOKEN_CHARCONST 
		{
							Node *a = CreateNode();
                strcpy(a->token,"literal");
                a=ProgramNode($1,"TOKEN_CHARCONST",a);

                $$ = a;
		}
		 | TOKEN_BOOLEANCONST
		 {
							Node *a = CreateNode();
                strcpy(a->token,"literal");
                a=ProgramNode($1,"TOKEN_BOOLEANCONST",a);

                $$ = a;
		};

%%

int main (int argc, char *argv[]){
    int flag;
	if(argc<3){
       cout<< "number of arguments is not valid!!\nplease enter 1.FileName 2.1 OR 0 (PRINT BY NAME | PRINT BY VALUE)" << endl;
	  return 0;
	}    
    if(argv[2][0]=='0'){
        printByTokenName =0;
    }else if(argv[2][0]=='1'){
        printByTokenName =1;
    }
	yyin = fopen(argv[1], "r");
	if(yyin == 0){
	cout << "Unable to open the file" << endl;
    return 0;
	}
	flag = yyparse();
	if(Root != NULL){
        cout<<"\n*************************************** PREORDER TRAVERSAL ***************************************\n\n"<<endl;
		PreOrderTraversal(Root);
        cout<<"\n\n*************************************************************\n*************************** PRINT PARSE TREE **************************\n********************************************************************\n\n";
        printTree(Root);
	}

	fclose(yyin);
	cout<<"\nParsing Done Successfully:)\n";
	return flag;
}

void yyerror(const char *error_message){
  cout<<"parser gave error: "<<error_message<<" at line "<<numLines<<endl;
  exit(-1);
}


Node* CreateNode()
{
 Node *newNode = new struct Node();
 newNode->ptr = NULL;
 newNode->child = NULL;
 newNode->lastchild = 0;
 newNode->isshow=1;
 strcpy(newNode->token, "");
 strcpy(newNode->type, "");
 strcpy(newNode->valname, "");
 return(newNode);
}
Node* ProgramNode(Node* newNode, Node* t)
{
	if(t->child == NULL)
		t->child = newNode;
	else
	{
		Node *itr;
		for(itr = t->child; itr->ptr != NULL; itr = itr->ptr);
		itr->ptr = newNode;
	}
	return(t);
}

Node* ProgramNode(string valname, string token, Node* t)
{
	Node *newNode = CreateNode();
	newNode->lastchild = 1;
	strcpy(newNode->valname, valname.c_str());
	strcpy(newNode->token, token.c_str());
	t = ProgramNode(newNode,t);
	return (t);
}

void PreOrderTraversal(Node *node)
{
    Node *itr;
    print(node);
  for(itr = node->child; itr != NULL; itr = itr->ptr)
	  PreOrderTraversal(itr);
}

void print(Node* node)
{
if((printByTokenName==1) && (node->lastchild))
    {
     cout<< node->token<<" ";
     output.append(node->token);
     output.append(" ");
    }
    else if((printByTokenName==0) && (node->lastchild))
    {
    cout<< node->token<<" "<<node->valname<<" " ;
    output.append(node->valname);
    output.append(" ");
    }
    else
    {
        cout<<"<"<< node->token <<"> ";
        output.append(node->token);
        output.append(" ");
    }
}

void printTree(Node *node)
{
  Node *itr;

	for(int i=1;i<num_nodes;i++)
	  cout<<"\t";

	if(num_nodes)
	  cout<<"\\";
	if((printByTokenName==1) && (node->lastchild))
	{
	 cout<< node->token << "\n";
	 output.append(node->token);
	 output.append(" ");
	}
	else if((printByTokenName==0) && (node->lastchild))
	{
	cout<< node->token << " " << node->valname << endl;
	output.append(node->valname);
	output.append(" ");
	}
	else
	{
	cout<< node->token << "\n";
	output.append(node->token);
	output.append(" ");
	num_nodes++;
	}

  for(itr = node->child; itr != NULL; itr = itr->ptr)   
	  printTree(itr);

  if(node->lastchild==0)
	num_nodes--;
}