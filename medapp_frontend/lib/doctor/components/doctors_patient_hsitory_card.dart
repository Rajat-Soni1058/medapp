import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DPHcard extends StatelessWidget {
  final String caseType;
  final DateTime datetime;
  final String name;
  const DPHcard({
    Key? key,
    required this.caseType,
    required this.datetime,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 140,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            //left part
            Container(
              width: 4,
              height: 50,
              decoration: BoxDecoration(
                color: (caseType == 'emergency')? Colors.red :Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(width: 12,),
            Expanded(child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color:(caseType == 'emergency')? Colors.red.withOpacity(0.15):Colors.blue.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child:  (caseType == 'emergency')?const Text(
                  'Emergency Case',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  
                ),):const Text(
                  'Normal Case',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
        
              SizedBox(height: 10,),
              //name
              Text(name,style: GoogleFonts.manrope(fontWeight: FontWeight.bold,fontSize:18,color: Colors.black),),
              SizedBox(height: 10,),
              Text("consulted on: ${datetime}",style: GoogleFonts.manrope(fontWeight: FontWeight.bold,fontSize:12,color: Colors.grey),),
              ],
            )),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                 style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                    ),
                onPressed: (){}, child: 
              Text('View Details',style: GoogleFonts.manrope(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.white),)
              ),
            )
        
          ],
        ),
      ),
    );
  }
}


