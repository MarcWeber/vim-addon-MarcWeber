" syntax match Entity "pos => #pos([^)]*)" conceal cchar=& | setlocal conceallevel=2
" %s/pos => #pos([^)]*)//g
" 
" setlocal tags+=~/haxe-lib/tags
" %s/pos =>[^(]*([^)]*)//g
" CFComplete haxe#CompleteClassNames
" OFComplete haxe#CompleteHAXE

inoremap <buffer> <c-q> ${}<left>
fun! s:LTSp(s)
  return vim_addon_other#InsertLT(' ',a:s,' ')
endf

inoremap <buffer> <c-c> //<space>
inoremap <buffer> <c-n><c-h> new<space>Hash();
inoremap <buffer> <m-s><m-g> String
inoremap <buffer> <m-a><m-y> Array<
inoremap <buffer> <m-n> new<space>
inoremap <buffer> <m-<> <>\<left>
inoremap <buffer> <m-v><m-d> Void
inoremap <buffer> <m-.> <c-r>=<sid>LTSp(".=")<cr>

setlocal fdm=marker

" call vl#lib#completion#contextcompletion#InitContextCompletion(
"          \ [ [ "Tab",'<c-tab>','b:tab_compl']
" 	 \ , [ "CR" ,'<cr>' ,'b:cr_compl' ,"\<cr>"] ])

" AddTabCompletion spf \<bs>\<bs>tatic\<space>public\<space>function
" AddTabCompletion p public
" AddTabCompletion pd public
" AddTabCompletion pv \<bs>rivate\<space>var
" setlocal autoindent
" AddTabCompletion i import
setlocal cindent

"au Haxe BufWritePost <buffer> exec "normal \<F2>:wincmd p\<cr>"

inoremap <buffer> <m-t><m-r> trace("");<left><left><left>
inoremap <buffer> <m-t><m-s> trace(haxe.Serializer.run( <++> ));<left><left><left>
inoremap <buffer> <m-r><m-n> return<space>
inoremap <buffer> <m-v> var<space>
inoremap <buffer> <m-p> pubilc<space>
inoremap <buffer> <m-t> this.

inoremap <buffer> <m->> <c-r>=<sid>LTSp("->")<cr>

noremap <buffer> qd :FlexDoc<space><c-r>=expand('<cword>')<cr>

command! -buffer AdobeDocs -args=0 exec '!opera http://www.google.com/search?hl=de&q='.expand('<cword>').'+site%3Ahttp%3A%2F%2Flivedocs.adobe.com%2F&btnG=Suche&lr=&aq=f&oq='

" ====================== ENDE ==
finish

HXCPP_M64=1

trace(haxe.Serializer.run( params ));

word site:http://livedocs.adobe.com/


inoremap <buffer> <m-t> this.


/*var params:Dynamic<String> = flash.Lib.current.loaderInfo.parameters;*/



    The [Lambda] class is a collection of functional methods in order to
    function array<A>( it : Iterable<A> ) : Array<A> {
    function list<A>( it : Iterable<A> ) : List<A> {
    function map<A,B>( it : Iterable<A>, f : A -> B ) : List<B> {
    function mapi<A,B>( it : Iterable<A>, f : Int -> A -> B ) : List<B> {
    function has<A>( it : Iterable<A>, elt : A, ?cmp : A -> A -> Bool ) : Bool {
    function exists<A>( it : Iterable<A>, f : A -> Bool ) {
    function foreach<A>( it : Iterable<A>, f : A -> Bool ) {
    function iter<A>( it : Iterable<A>, f : A -> Void ) {
    function filter<A>( it : Iterable<A>, f : A -> Bool ) {
    function fold<A,B>( it : Iterable<A>, f : A -> B -> B, first : B ) : B {
    function count<A>( it : Iterable<A> ) {
    function empty( it : Iterable<Dynamic> ) : Bool {


  class Reflect
  class String
  class StringBuf
  class StringTools
  class HTTP
  class FlashJsConnection

  ==== logging / debugging ====
  Firebug.trace !!!
  Firebug.redirectTraces() !!!
  Log.setColor
  Log.clear
  Log.trace
  Stack

    I use this function:

            public static function setupTrace()
        {
            var f = haxe.Log.trace;

            haxe.Log.trace = function(v, ?pos)
            {
                f(v, pos);
                Lib.print("<br />");
            }
        }

    On Thu, Mar 25, 2010 at 11:07 AM, Randy Stauner
    + (25 quoted lines)

    + (7-line signature)
      -    Randy Stauner to The  1:27am (13 hours ago)
      also, if you're a firefox+firebug user, you might like

      haxe.Firebug.redirectTraces();

      + (53 quoted lines)
      x Attachment: sup-attachment-1269522563-718.html (text/html; 2k)
      + (3-line signature)
        -    Heinz HÃ¶lzer to haxe 11:10am (3 hours ago)
        thx, by the way there is still an issue with Firebug and Flash.
        This hack is still needed:
        <head>
        <script type="text/javascript">/* <![CDATA[ */ try { console.log(); }
        catch (e) { }; /* ]]> */</script>
        </head>

        best,
        h

        + (63 quoted li

        for (i in 0...10) ..
