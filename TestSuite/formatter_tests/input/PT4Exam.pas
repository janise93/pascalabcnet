unit PT4Exam;

interface

procedure Task(name: string);

implementation

uses 
  PT4, System.IO, System.Text;

procedure ToWin(s: string);
begin
var fs: StreamReader := new StreamReader(s);
var fs1: StreamWriter := new StreamWriter('$$.tmp', false, Encoding.Default); 
fs1.Write(fs.ReadToEnd);
fs.Close;
fs1.Close;    
System.IO.File.Delete(s);
System.IO.File.Move('$$.tmp',s);
end;

var 
  NextTask: boolean := False;
  s1, s2: string;

procedure Task(name: string);
var 
  f: textfile;
begin
  PT4.Task(name);
  if NextTask then
    exit;
  NextTask := True;  
  GetS(s1);
  GetS(s2);
  if not FileExists(s1) then
  begin
    s1 := 'null1.tst';
    Assign(f, s1);
    Rewrite(f);
    Close(f);
  end;
  if s2 = '' then
    s2 := 'null2.tst';
  Assign(input, s1);
  Reset(input);
  Assign(output, s2);
  Rewrite(output);
end;

initialization

finalization
  Close(input);
  Close(output);
  if s1 = 'null1.tst' then
    Erase(input);
  if s2 = 'null2.tst' then
    Erase(output)
  else  
    ToWin(s2);

end.
