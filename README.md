== lambdalisp == 

Welcome to my langauge. (For the working version 1.0, see old program file)

What do:
- compiles to ISO C
- is made of ISO C
- interpreted
- has first class macros
- language spec is less than a page 
- hacks on other languages

Motivation:  \
I find that lisp is a mathematical idea more than it is a
programming language. So lisp is something that a
programmer benefits from thinking about, but obsession over implementation is not healthy. The idea of lisp can be implemented anywhere in any language. 

For example: \
python <> hy \
C <> guile \
Java <> clojure


First the defintion of lambda calculus \
https://en.wikipedia.org/wiki/Lambda_calculus#Formal_definition

Lisp is lambda calculus with the added ability to abstract away lambda expressions through naming.

During the first lecture of SICP it is pointed out that a given programming language has three sets: primitive elements, means of combination, means of abstraction.

So for lisp this is \
primitve elements: lambda, * \
means of combination: s-expressions := (f a) \
means of abstraction: define

So lisp very much fits the definition of a programming language. Due
to lambda calc it is also a turing complete language. And due to the
mathematical definition of a function, describing an entire process
with just the convention 

(do-this using-this or-this),

is about as
simple as describing a procedure can get. The thing to note that
functions map elements from one set to another. There is no
restriction on what a set should be. It is possible to restrict it to input and returning values in the code, so called pure functional language programming, but lambda's don't care. Memory adresses are just lists of church numbered bits to a lambda calc processor.



<!--- ideal lisp (IdeaLisp), or the impractical lisp (ImpLisp), or lambda calc bus (LaCaBu). Whatever. Lambda lisp. --->

<!--- With some abstraction, lambda calculus s-expressions are lists. So anything that attempts to compute lambda calc is a LISt Processor or LISP. S-expressions from lambda calculus are associative, as in (((f a) b) c) can be written as (f a b c) for shorthand. --->

I would like to take advanatage of this definition freedom to declare two methods for evalutaing an s-expression: evaluation from the inside first, and evaluation from the outside first. This time I will imbed the evaluation scheme int the first term of an s-expression. (previously I changed the s-expression itself to denote evaluation scheme. This is clearer but more verbose when programming).

Evaluating the outside of s-expressions first is how a mathematician would do lambda calculus. It allows for macros as first class objects. In a sense it is trully Hilberts description of mathematics as functions on strings. With this scheme any language syntax could be described with lambda calculus. Example:

(arithmetic 2 * 8 + 2 - 15)

This scheme is great for string manipulations. But on its own it requires more complex function defintions and can lead to passing larger and larger strings.

So the other method is evaluate internally first. In this case the expression being evaluated is always either a symbol, or a s-expression. This allows for dispatch of a procedure that does something else besides manipulating how the code looks.

2 * 8 + 2 \
vs \
(+ 2 (* 2 8))

The symbol + does not represent a function that has to be made to consider how to add lists to a number. It only has to consider numbers.

int numbers[5]; \
int\* p = numbers;  \
vs \
(define numbers (array-of 5)) \
(define p (pointer-to numbers))

This evaluation scheme allows for easy operation abstractions. How does (array-of 5) work? we do not need to know, just that arrays are quicker access than lists and that is what we need.

<!---
We have a few alphabets, variables, lambda expressions, and parenthesis. These form the needed parts for a lambda expression. \
V = {v_1, ..., v_n, ... } \
l = {lambda, .} \
p = {(,)} \
S = V \union l \union p \
The set of lambda expressions A is defined inductively \
if x is variable, then x is in A \
if x is a variable \

This project is largely an exploration of mathematical logic. The evalaution scheme defaults to depth first.

First and most important is the evaluation scheme of a lambda expression in an s-expression. Typical lisps use what is called greedy evaluation. --->

Now to define what each primitive does in terms of lambdas.

(define name object) \
Define gives a name to an object. This is not strictly part of lambda calculus but the meta-language of describing lambda calculus. It does nothing to computability but it helps the user be able to abstract away lambda calculus terms. 
<!--- think of it as a C style string replacement --->

(function (bound-variable-1 ... bound-variable-n) expression-1 ... expression-n returned-expression) \
Function is an implementation of a lambda expression. internal arguements are evaltuated first. 

Aside from the evaluation scheme here is a proof that both terms can generate each other. \
(lambda (bound-variable-1 ... bound-variable-n) returned-expression) ==
(function (bound-variable-1 ... bound-variable-n) returned-expression). \
And finally \
(lambda (local-variable-1 ... local-variable-n 
         bound-variable-1 ... bound-variable-n) returned-expression) expression-n ... expression-1 == 
(function (bound-variable-1 ... bound-variable-n) 
       expression-1 ... expression-n returned-expression).

Making a lambda using function: (function (bound-variable-1) returned-expression) => (lambda (bound-variable-1) returned-expression). \


(macro literals input-pattern output-pattern)  \
Macro works like the classical lambda. The patterns are input and output of a lambda expression. These are cleanly taken care of via alpha conversion. The addition of literals allows the ability to specify when alpha conversion should not happen. This is literally all there is to making sanitary macros. Common Lisp could not get this straight for decades. And Scheme did not even have them in the language until much later. But this is due to compuaton limits of old computers.
 
(function () (define (list-manip literals) [etc...]) (list-manip '(input-pattern) output-pattern))) \
use \
(define say (macro (say ...) (say this ...) (print (str this ...))) \
(say cats are cool) => "cats are cool" 

language spec
EBNF: \
s_expression = atomic_symbol | \
               list  

list = "(" s_expression < s_expression > ")"

atomic_symbol = letter atom_part

atom_part = empty | letter atom_part 

letter = UTF-8 characters aside from ( and )

empty = " "

<!---
 I designed this language to be a form of lisp that is closer to the underlying lambda calculus than scheme or other lisps seem to be. As an example I designed two function evaluation styles: The typical is greedy evaluation, and a more macro like style. Both follow the rules of being purely functional, and are first class citizens.

The main feature is that it is written in C so it can run on anything, and with some macro-ing this means being to run any language that can be thought up.

For example take this line of code:
(excutable (python3 print ("cats = " + str (1 + 2))) 

This takes what is syntactically python3, to lambda expressions and some C primitives, compiles it to C, which then compiles it to the local machine code. The executable can then be caught by a define, written to a file, or even used as a lambda.

This can be extended to compile to other langauges, meaning being able to write java from python, assembly from perl, etc..


conventions:
file name extension .l (lambda, or lisp)
library extension .ll (lambda library)

todo:
*** change ^C exit to include ^D --->
# mylisp
