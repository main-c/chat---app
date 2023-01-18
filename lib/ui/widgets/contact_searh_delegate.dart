// import 'package:chat_app/models/user_model.dart';
// import 'package:chat_app/ui/themes/color.dart';
// import 'package:chat_app/ui/widgets/contact_card.dart';
// import 'package:flutter/material.dart';

// class ContactSearchDelegate extends SearchDelegate {
//   @override
//   String? get searchFieldLabel => "Search a user";

//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//         onPressed: (() => close(context, null)),
//         icon: const Icon(
//           Icons.arrow_back_outlined,
//           color: CustomColors.blue,
//         ));
//   }

//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//           onPressed: () => (query.isEmpty ? close(context, null) : query = ''),
//           icon: const Icon(
//             Icons.clear,
//           ))
//     ];
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     List<Contact> results = contactList.where((element) {
//       var contact = element.username.toLowerCase();
//       var input = query.toLowerCase();
//       return contact.contains(input);
//     }).toList();

//     if (results.length == 0) {
//       return Center(
//           child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//         const Icon(
//           Icons.search_off,
//           color: CustomColors.secondGreen,
//           size: 50,
//         ),
//         Text("Aucun resultat trouvé pour $query",
//             style: Theme.of(context).textTheme.headline2?.copyWith(
//                   color: CustomColors.secondGreen,
//                 ))
//       ]));
//     } else {
//       return ListView.builder(
//           itemCount: results.length,
//           itemBuilder: (context, index) {
//             final suggestion = results[index];
//             return ContactCard(
//               contact: suggestion,
//             );
//           });
//     }
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     List<Job> suggestions = jobList.where((element) {
//       var job = element.title.toLowerCase();
//       var input = query.toLowerCase();
//       return job.contains(input);
//     }).toList();

//     return ListView.builder(
//         itemCount: suggestions.length,
//         itemBuilder: (context, index) {
//           final suggestion = suggestions[index];
//           return ContactCard(
//             job: suggestion,
//           );
//         });
//   }
// }
