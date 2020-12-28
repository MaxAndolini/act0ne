import 'dart:math';

class Task{

  var dailyTasks;
  var weeklyTasks;
  var monthlyTasks;


  Task(this.dailyTasks, this.weeklyTasks, this.monthlyTasks);

  Task.withdailyTasks(var dailyTasks){
    this.dailyTasks = dailyTasks ;
  }

  Task.withweeklyTasks(var weeklyTasks){
    this.weeklyTasks = weeklyTasks ;
  }

  Task.withmonthlyTasks(var monthlyTasks){
    this.dailyTasks = monthlyTasks ;
  }

}