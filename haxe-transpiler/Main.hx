import Token;
import Sys;
using StringTools;

class Main {
  public static function main() 
  {
    var text = '(println "hello world")\n;(println "comment")\n(println "notcomment")';
    var tokens = lex(clean_comments(text), 0);
    Sys.println(Value("10"));
  }

  public static function clean_comments(text:String):String
  {
    var result = "";

    var lines = text.split("\n");
    for(line in lines)
    {
      var lineT = line.trim();
      if(! (lineT.charAt(0) == ";"))
      {
        result += line;
      }
    }
    return result;
  }

  public static function find_second(text:String, char:String):Int
  {
    var index = 1;
    while(index < text.length)
    {
      if(text.charAt(index) == char)
      {
        return index;
      }
      index += 1;
    }
    throw "outRange";
  }

  public static function find_next_match(text:String, reg:EReg):Int
  {
    var index:Int = 1;
    while(index < text.length)
    {
      if(reg.match(text.charAt(index)))
      {
        return index;
      }
      index += 1;
    }
    throw "outRange";
  }

  public static function lex(text:String, line:Int):Array<Token> 
  {

    Sys.println(text);
    return [];
  }
}
