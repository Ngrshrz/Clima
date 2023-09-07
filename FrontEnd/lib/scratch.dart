
 import 'dart:io';

void main() {
  
 permorftasks();


}

void permorftasks() async{
task1();
print(task2());
//String task2Data = await task2();
//task3(task2Data);
}


void task1(){
String result = ' task1 data';
print('task1 completed');
}
 Future<String> task2() async {
Duration threeseconds = Duration( seconds:3 );
String? result ;
await Future.delayed(threeseconds ,(){
  result = ' task2 data';
  print('task2 completed');
});
return result! ;
}

void task3( String task2Data){
String result = ' task3 data';
print('task3 completed $task2Data');
}










