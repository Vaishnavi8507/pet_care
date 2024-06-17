import 'package:flutter/material.dart';
import 'package:pet_care/provider/pet_sitter_provider.dart';
import 'package:provider/provider.dart';

class PetSitters extends StatefulWidget {
  const PetSitters({Key? key}) : super(key: key);

  @override
  _PetSittersState createState() => _PetSittersState();
}

class _PetSittersState extends State<PetSitters> {
  late PetSitterProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = PetSitterProvider()..fetchVolunteers();
  }

  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _provider,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Pet Sitters'),
        ),
        body: Consumer<PetSitterProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (provider.volunteers.isEmpty) {
              return Center(child: Text('No volunteers found'));
            }
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(15),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () => _showSortOptions(context),
                            child: Card(
                              color: Colors.white.withOpacity(0.8),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 15),
                                child: Row(
                                  children: [
                                    Icon(Icons.sort, color: Colors.grey),
                                    SizedBox(width: 5),
                                    Text(
                                      'Sort By',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Card(
                              color: Colors.white.withOpacity(0.8),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 15),
                                child: Row(
                                  children: [
                                    Icon(Icons.sort, color: Colors.grey),
                                    SizedBox(width: 5),
                                    Text(
                                      'Dogs',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Card(
                              color: Colors.white.withOpacity(0.8),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 15),
                                child: Row(
                                  children: [
                                    Icon(Icons.sort, color: Colors.grey),
                                    SizedBox(width: 5),
                                    Text(
                                      'Cats',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Card(
                              color: Colors.white.withOpacity(0.8),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 15),
                                child: Row(
                                  children: [
                                    Icon(Icons.sort, color: Colors.grey),
                                    SizedBox(width: 5),
                                    Text(
                                      'Birds',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    itemCount: provider.volunteers.length,
                    itemBuilder: (context, index) {
                      final volunteer = provider.volunteers[index];
                      return VolunteerCard(volunteer: volunteer);
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

   void _showSortOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              key: UniqueKey(),
              title: Text('Price - Low to High'),
              onTap: () async {
                await _provider.sortByPriceAsc();
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Price - High to Low'),
              onTap: () async {
                await _provider.sortByPriceDsc();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
class VolunteerCard extends StatelessWidget {
  final Map<String, dynamic> volunteer;

  const VolunteerCard({Key? key, required this.volunteer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.8),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: volunteer['profileImageUrl'] != null
                  ? NetworkImage(volunteer['profileImageUrl'])
                  : AssetImage('assets/images/default_profile.png')
                      as ImageProvider,
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    volunteer['name'],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.grey, size: 20),
                      SizedBox(width: 5),
                      Text(
                        volunteer['locationCity'] ?? 'Unknown',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      if (volunteer['prefersDog'] == true)
                        Container(
                          width: 20,
                          height: 20,
                          child: Image.asset('assets/icons/dog.png'),
                        ),
                      if (volunteer['prefersCat'] == true)
                        Container(
                          width: 20,
                          height: 20,
                          child: Image.asset('assets/icons/cat.png'),
                        ),
                      if (volunteer['prefersRabbit'] == true)
                        Container(
                          width: 20,
                          height: 20,
                          child: Image.asset('assets/icons/rabbit.png'),
                        ),
                      if (volunteer['prefersBird'] == true)
                        Container(
                          width: 20,
                          height: 20,
                          child: Image.asset('assets/icons/bird.png'),
                        ),
                      if (volunteer['prefersDog'] == true ||
                          volunteer['prefersCat'] == true ||
                          volunteer['prefersRabbit'] == true ||
                          volunteer['prefersBird'] == true)
                        Text(
                          '|',
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                        ),
                      if (volunteer['providesDogWalking'] == true)
                        Container(
                          width: 20,
                          height: 20,
                          child: Image.asset('assets/icons/pet_walk.png'),
                        ),
                      if (volunteer['providesHomeVisits'] == true)
                        Container(
                          width: 20,
                          height: 20,
                          child: Image.asset('assets/icons/pet_home.png'),
                        ),
                      if (volunteer['providesHouseSitting'] == true)
                        Container(
                          width: 20,
                          height: 20,
                          child: Image.asset('assets/icons/pet_sitter.png'),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Text(
                  'From',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Text(
                  '${volunteer['minPrice'] ?? 0} INR',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
