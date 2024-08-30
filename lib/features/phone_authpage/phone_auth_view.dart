
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pinput/pinput.dart';
import 'phone_auth_controller.dart';

class PhoneAuthenticationView extends GetView<PhoneAuthenticationController>{
  const PhoneAuthenticationView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset(
              'assets/background.jpg',
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                ),
                padding:const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Enter your mobile number to receive an ',
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold,color: Colors.black.withOpacity(0.5)),
                    ),
                      Text(
                      ' OTP',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black.withOpacity(0.5)),
                    ),
                  const SizedBox(height: 20),
                     Form(
                     // key: controller.phoneKey,
                       child: TextFormField(
                       // controller: controller.phoneController,
                        keyboardType: TextInputType.phone,
                        decoration:const InputDecoration(
                          labelText: 'Mobile Number',
                          hintText: '1234567890',
                          prefixText: '+91 ',
                          prefixIcon: Icon(Icons.phone),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          )
                        ),
                        validator: (value) {
                          if(value == ''){
                            return 'Please Enter Mobile Number';
                          }
                           if(value!.length != 10){
                            return 'Mobile number must have 10 digits';
                          }
                          return null;
                        },
                       ),
                     ),
                   const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                       // controller.checkValidate();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        padding:const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      child:const Text('Get OTP',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600),),
                    ),
                  const  SizedBox(height: 20,),
      
                    Obx(() => controller.isCodeSent.value ? Column(
                      children: [
                          Text(
                      'Enter the code send to your number ',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black.withOpacity(0.4)),
                    ),
                  
                      Padding(
                        padding: const EdgeInsets.only(top: 10,bottom: 15),
                        child: Text(
                         controller.phoneController.text,
                        style:const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                         ),
                      ),
                   
                //    Obx(()=> PinFieldAutoFill(
                //                     // currentCode: controller.codeValue,
                //                      codeLength: 6,
                //                      controller: controller.otpController,
                //                      onCodeChanged: (code) {
                //                        print("onCodeChanged $code");
                //                        // setState(() {
                //                        /// controller.codeValue = code.toString();
                //                        // });
                //                      },
                //                      onCodeSubmitted: (val) {
                //                        print("onCodeSubmitted $val");
                //                      },
                //                       decoration: UnderlineDecoration(
                //   textStyle: const TextStyle(fontSize: 20, color: Colors.black),
                //   colorBuilder: FixedColorBuilder(Colors.black.withOpacity(0.3)),
                // ),
                //                    ),
                //    ),

                     Pinput(
                                      length: 6,
                                     // controller: controller.otpController,
                                      defaultPinTheme: PinTheme(
                                         width: 56,
                                        height: 56,
                                        decoration: BoxDecoration(
                      border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFF19F420),
                                      ),
                                      
                                      ),
                                    ),
                    
              const SizedBox(height: 15,),
              Row(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   const Text('Remaining Time : ',style: TextStyle(fontSize: 18,color: Colors.red),),
                   Obx(() => Text('${controller.remainingTime.value}s', style: const TextStyle(fontSize: 18, color: Colors.red))),
                ],
              ),
              const SizedBox(height: 15,),
               ElevatedButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        //controller.verifyOtp();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                      ),
                      child:const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Verify OTP',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600),),
                      ),
                    ),
                    
                      ],
                    ) : Container(),
                    )
                    
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
}