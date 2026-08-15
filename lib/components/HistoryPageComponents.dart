import "package:flutter/material.dart";


class HistoryCard extends StatelessWidget{

  final String title,amount,date,notes;


  const HistoryCard({super.key,required this.title,required this.amount,required this.date,required this.notes});


@override
Widget build(BuildContext context){
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.redAccent,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 3), // changes position of shadow
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),),
        const SizedBox(height: 10,),
        Text("Amount : $amount",style: const TextStyle(fontSize: 16,color: Colors.white),),
        const SizedBox(height: 5,),
        Text("Date : $date",style: const TextStyle(fontSize: 16,color: Colors.white),),
        const SizedBox(height: 5,),
        Text("Notes : $notes",style: const TextStyle(fontSize: 16,color: Colors.white),),
      ],
    ),
  );

}
}