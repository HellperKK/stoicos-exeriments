enum Token {
    Value(val:String);
    Variable(name:String);
    NSpace(name:String, key:String);
    Proce(vals:Array<Token>);
    Blocke(vals:Array<Token>);
    Array(vals: Array<Token>);
}