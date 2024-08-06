

import 'package:flutter/material.dart';

import '../../../models/HomeCategory.dart';
import '../../../services/api_load_home_config.dart';

class HomeServicePrv extends ChangeNotifier {
    List<Homecategory> categories=[];
    bool isLoading=false;
    BuildContext? context;
    HomeServicePrv(ctx){
        context = ctx;
        initial();
    }

    Future initial() async {

        if(!isLoading){
            isLoading=true;
            await ApiLoadHomeConfig.load_home_config().then((data){
                var checkData=data?["categories"];
                if(checkData!=null&&checkData is List){
                    categories = checkData.map((c) => Homecategory.fromMap(c)).toList();
                    notifyListeners();
                }
                else{

                }
                isLoading=false;
            });
        }

    }
}