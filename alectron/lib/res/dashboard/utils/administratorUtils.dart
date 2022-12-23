import 'package:alectron/res/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:translator/translator.dart';

class AdministrationUtils {
  final translator = GoogleTranslator();
  addAdministrator({email,password,required Map<String,dynamic> data}) async {
    final app = await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: 'AIzaSyCKTSJcV6tFt2mQVY7aNc02tfqwSmTs3Gc',
            appId: '1:1074410476128:web:5785d0a34c30534cf42905',
            messagingSenderId: '1074410476128',
            projectId: 'alect-ron'));
    final auth = FirebaseAuth.instanceFor(app: app);
    final firestore = FirebaseFirestore.instance;
    try{
      await auth.createUserWithEmailAndPassword(email: email, password: password).then((value)async{
        data.addAll({'date_created' : DateTime.now()});
        await firestore.collection('administrator').doc(value.user!.uid).set(data);
        auth.signOut();

      });

      toastSuccess('Successfully Added');
    }on FirebaseAuthException catch (e){
      toastError(e.message);

    }

  }
  
  deleteAdminstrators({email,password})async{
    final firestore = FirebaseFirestore.instance;
    final app = await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: 'AIzaSyCKTSJcV6tFt2mQVY7aNc02tfqwSmTs3Gc',
            appId: '1:1074410476128:web:5785d0a34c30534cf42905',
            messagingSenderId: '1074410476128',
            projectId: 'alect-ron'));
    final auth = FirebaseAuth.instanceFor(app: app);
    try{
      auth.signInWithEmailAndPassword(email: email, password: password).then((value)async{
        await firestore.collection('administrator').doc(auth.currentUser!.uid).delete();
        await auth.currentUser!.delete().then((value){
          toastSuccess('Deleted Successfully');
        });
      });
    }on FirebaseAuthException catch(e){
      toastError(e.message);
    }
    
    
  }
}
