import 'package:cloud_firestore/cloud_firestore.dart';

String COL_USER = "Users";

String USER_KEY = 'user_key'; //uid
String USER_EMAIL = 'email';
String USER_USERNAME = 'username';
String USER_ALL_DATA = 'all_data';
String DIARY_TITLE = 'title';
String DIARY_WISH = 'wish';
String DIARY_TY = 'ty';
String DIARY_TMR = 'tmr';
String DIARY_SURP = 'surprise';
String TODO = 'todo';
String DIARY = 'diary';


/*
Collection       DOC        DATA
  User      ->   UID    ->   uid
                        ->  email
                        ->  username
                        ->  all_data : {
                           '2021-09-08' :  {
                             'diary': {
                               'title' : '',
                               'wish' : [],
                               'todydo': '',
                               'tomdo' : '',
                               'surprise' : '',
                             
                             }, 
                             'todo' :{
                               '시작시간' : [시간,Todo],
                               '시작시간' : [시간,Todo],
                               '시작시간' : [시간,Todo]
                             }
                            ],

                            '2021-09-09' :  [
                             {'diary' : 'bulabulabulabula'},
                             {'todo'  :  ["first todo" , "second todo" , "third todo"]}
                                  ],

                            '2021-09-10' :  [
                             {'diary' : 'bulabulabulabula'},
                             {'todo'  :  ["first todo" , "second todo" , "third todo"]}
                                  ],
                          } 
                        
*/