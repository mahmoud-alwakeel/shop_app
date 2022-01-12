import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopp_app/modules/search/cubit/cubit.dart';
import 'package:shopp_app/modules/search/cubit/states.dart';
import 'package:shopp_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state){} ,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    defaultFormField(
                        controller: searchController,
                        type: TextInputType.text,
                        validate: (String value){
                          if(value.isEmpty){
                            return 'enter text to search';
                          }
                          return null;
                        },
                      onSubmit: (String text){
                          SearchCubit.get(context).search(text);
                      },
                        label: 'search',
                        prefix: Icons.search,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    if(state is SearchLoadingState)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 10.0,
                    ),
                    if(state is SearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) => buildListProduct(SearchCubit.get(context).model.data.data[index], context, isOldPrice : false),
                        separatorBuilder: (context, index) => SizedBox(height: 10,),
                        itemCount: SearchCubit.get(context).model.data.data.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
