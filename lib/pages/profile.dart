import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  TextEditingController SalaryController =
      TextEditingController();
  
  TextEditingController NameController =
      TextEditingController();


  initState() {
    super.initState();
    loadProfile();
  }


  loadProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      SalaryController.text = (prefs.getDouble('monthlyIncome') ?? 0.0).toString();
      NameController.text = prefs.getString('name') ?? '';
    });
  }



	@override
	Widget build(BuildContext context) {

    final width=MediaQuery.of(context).size.width;
     final height = MediaQuery.of(context).size.height;

		return Scaffold(
			appBar: AppBar(
				title: const Text('Profile'),
				centerTitle: true,
			),
      body:Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          
				children: [
          
          Container(
            width:width,
            height: height*0.1,
  
            decoration: BoxDecoration(
              
              color: Colors.amber,
              borderRadius: BorderRadius.circular(15),
            ),

            child:
            
            Padding(
              padding: const EdgeInsets.all(10.0),
              child:
             Row(
              children: [
                
                Text('Monthly Income',style: TextStyle(fontSize: 20, color: Colors.white),),

                 SizedBox(width: 15),
              Expanded(
              
                
                child:
                TextField(
                  controller: SalaryController,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                  textAlign: TextAlign.end,
                  decoration: InputDecoration(
                    hintText: 'Enter',
                    hintStyle: const TextStyle(fontSize: 18, color: Colors.white54),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                  keyboardType: TextInputType.number,
                ),
              )
                
              ],
            ),
            )
            ),

SizedBox(height: 20),

            Container(
            width:width,
            height: height*0.1,
  
            decoration: BoxDecoration(
              
              color: Colors.amber,
              borderRadius: BorderRadius.circular(15),
            ),

            child:
            
            Padding(
              padding: const EdgeInsets.all(10.0),
              child:
             Row(
              children: [
                
                Text('Enter you Name',style: TextStyle(fontSize: 20, color: Colors.white),),

                 SizedBox(width: 15),
              Expanded(
              
                
                child:
                TextField(
                  controller: NameController,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                  textAlign: TextAlign.end,
                  decoration: InputDecoration(
                    hintText: 'Enter',
                    hintStyle: const TextStyle(fontSize: 18, color: Colors.white54),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                  keyboardType: TextInputType.text,
                ),
              )
                
              ],
            ),
            )
            ),

            SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setDouble('monthlyIncome', double.tryParse(SalaryController.text) ?? 0.0);
                await prefs.setString('name', NameController.text);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Profile saved!')),
                );
              },
              child: const Text(
                'Save Profile',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),


            SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.clear();
                SalaryController.text = '';
                NameController.text = '';
                

                
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Profile cleared!')),
                );
              },
              child: const Text(
                'Clear Profile',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          
          
				],
			)
    )
		);
	}
}
