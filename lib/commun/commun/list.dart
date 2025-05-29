import 'package:syncfusion_flutter_calendar/calendar.dart';

List<String> classes = ['All', '8B1', '8B2', '8B3', '9B1', '9B2'];
List<String> chapitres = [
  "Systeme d'exploitation",
  "Culture informatique",
  "Reseau informatique",
  "Architecture des ordinateurs"
];
List<String> typeExam = [
  'Devoir de controle',
  'Devoir de synthese',
  'Test',
  'Orale',
  'Projet'
];
List<String> discipline = ['P', 'A', 'Exclu', 'B'];
List<String> typeSeance = [
  "Cours",
  "Correction des exercices",
  "Correction de devoir",
  "Exam"
];
List<String> blocs = [];
List<String> apprenant = [
  'All',
  'Med Ali Bouaziz',
  'Yasmin Krichen',
  'Nawress Mkaddem',
  'Med Ali Bouoaziz',
  'Yasmikn Krichen',
  'Nawresks Mkaddem',
  'Jamila Boussif',
  'Montasslar Arif',
  'Mohsmen Harzallah',
  'Jamila Boussif',
  'Montassar Arif',
  'Mohsen Harzallah'
];
List<Map<String, dynamic>> daysSelection = [
  {'lib': 'Lundi', 'val': 1},
  {'lib': 'Mardi', 'val': 2},
  {'lib': 'Mercredi', 'val': 3},
  {'lib': 'Jeudi', 'val': 4},
  {'lib': 'Vendredi', 'val': 5},
  {'lib': 'Samedi', 'val': 6}
];
List<String> days = [
  'Lundi',
  'Mardi',
  'Mercredi',
  'Jeudi',
  'Vendredi',
  'Samedi',
  'Dimanche'
];
List<String> salles = [
  'A1',
  'A2',
  'A3',
  'info1',
  'info2',
  'Lph1',
  'Lph2',
  'Lsc.1'
];
/*
List<Widget> contentWidgets = [
  const PostsScreen(),
  const AbsenceManagementScreen(),
  Container(
    child: const Text('add circle'),
  ),
  const EditProfilePage(),
  Container(
    child: const Text('search'),
  ),
  const CreatePost(),
  const NotificationScreen(),
  Container(
    child: const Text('todo'),
  ),
  const CreateEmploi(),
  const TabBarNotifScreen(),
  Container(
    child: const Text('add messg temp replace Presence management'),
  ),
];   */
List<Appointment> teacherListSeance = [];
List<Appointment> apprenantListSeance = [];
/*
List<Widget> emploiList = [
  const AddSeanceProf(),
  ViewCalender(appointments: teacherListSeance),
  const AddSeanceApprenant(),
  ViewCalender(appointments: apprenantListSeance),
]; */
List<Map<String, dynamic>> durationMap = [
  {'lib': '1h', 'valeur': 60},
  {'lib': '1h30', 'valeur': 90},
  {'lib': '2h', 'valeur': 120},
  {'lib': '2h30', 'valeur': 150},
  {'lib': '3h', 'valeur': 180},
  {'lib': '3h30', 'valeur': 210},
  {'lib': '4h', 'valeur': 240}
];
List<String> seanceDurationLibelle = [
  '1h',
  '1h30',
  '2h',
  '2h30',
  '3h',
  '3h30',
  '4h'
];
List<int> seanceDuration = [60, 90, 120, 150, 180, 210, 240];
List<String> subjects = [
  'Math',
  'Seances naturelles',
  'Physique',
  'Arabe',
  'Français',
  'Anglais',
  'Sport',
  'Technique',
  'informatique'
];
List<String> enseignant = [
  'All',
  'Najia Ouaer',
  'Med Ali Bouaziz',
  'Yasmin Krichen',
  'Nawress Mkaddem',
  'Med Ali Bouoaziz',
  'Yasmikn Krichen',
  'Nawresks Mkaddem',
  'Jamila Boussif',
  'Montasslar Arif',
  'Mohsmen Harzallah',
  'Jamila Boussif',
  'Montassar Arif',
  'Mohsen Harzallah'
];
List<String> formations = [
  'LMD',
  'etudes medicales',
  "etudes d'ingenieurs",
];
List<String> lMD = [
  'Licence',
  'Mastère',
  'Mastère de recherche',
  'Mastère professionlle',
  'Doctorat',
  'Licence appliquée',
  'Licence fondamentale'
];
List<String> etdudesMedicales = [
  'Diplome national de docteur en médecine',
  'Diplôme national de docteur en médecine dentaire',
  'Diplôme national de docteur en pharmacie'
];
List<String> edudesIngenieurs = [
  'Cycle preparatoire',
  "Diplôme national d'ingenieur"
];
List<String> domaineFormations = [
  'Sciences fondamentales',
  'Informatique et télécommunication',
  'Sciences paramédicales',
  'Langues et Humanités',
  'Arts et Métiers de la mode',
  'Sciences Economiques et gestion',
  'Sciences Biologiques et Biotechnologie',
  "Sciences de l'ingenieur",
  'Sciences Médicales et pharmacetiques'
];
List<String> gouvernorats = [
  'Ariana',
  'Béjà',
  'Ben Arous',
  'Bizerte',
  'Gabès',
  'Gafsa',
  'Jendouba',
  'Kairouan',
  'Kasserine',
  'Kébelli',
  'Le Kef',
  'Mahdia',
  'La Mannouba',
  'Médenine',
  'Monastir',
  'Nabeul',
  'Sfax',
  'Sidi Bouzid',
  'Siliana',
  'Sousse',
  'Tataouine',
  'Tozeur',
  'Tunis',
  'Zaghouan'
];

List<String> nivScolaire = [
  'Première année',
  'Deuxième année',
  'Troisième année',
  'Quatrième année',
  'Cinquième année',
  'Sixième année',
  'Septième année',
  'Huitième année',
  'Neuvième année'
];
List<String> sections2annee = [
  "Sciences et technologie de l'information",
  "Economie et services",
  "Lettres",
  "Sport"
];
List<String> sections3annee = [
  "Sciences expérimentales",
  "Mathématiques",
  "Sciences techniques",
  "Economie et gestion",
  "Sciences de l'informatique"
];
List<String> matieres = [
  "اللغة العربية",
  "الرياضيات",
  "الإيقاظ العلمي",
  "علوم الحياة والارض",
  "جغرافيا",
  "تاريخ",
  "تربية(تشكيلية-تقنية-موسيقية)",
  "المواد الاجتماعية والتربية الاسلامية والتربية المدنية",
  "تربية بدنية",
  'Français',
  'Mathèmatiques',
  'Physique',
  'Chimie',
  'Sciences naturelle',
  'Technologie',
  'Mécanique/Electricité',
  'Economie gestion',
  'Informatique',
  'Anglais',
  'Allemand',
  'Italien',
  'Espagnol'
];
List<Map<String, dynamic>> secteursMF = [
  {'Secteur': 'Agriculture', 'sous-secteur': 'Agriculture'},
  {'Secteur': 'Agro-alimentaire', 'sous-secteur': 'Alimentation'},
  {
    'Secteur': 'Batiment, travaux publics et annexes',
    'sous-secteur': 'Sanitaires froid et climatisation'
  },
  {
    'Secteur': 'Mécanique generale et construction metallique',
    'sous-secteur': "Mécanique d'entrtien"
  },
  {
    'Secteur': "Métiers d'art et de l'artisanat",
    'sous-secteur': 'Métiers des métaux'
  },
  {'Secteur': 'Services et et industries', 'sous-secteur': 'Arts graphiques'},
  {'Secteur': 'Textile et habillement', 'sous-secteur': 'Confection'},
  {
    'Secteur': 'Tourisme et hotelleries',
    'sous-secteur': 'Hôtellerie et restauration'
  },
  {
    'Secteur':
        'Transport, conduite et maintenance des vehicules et des engins de travaux publics',
    'sous-secteur': 'Transport'
  },
  {
    'Secteur':
        'Transport, conduite et maintenance des vehicules et des engins de travaux publics et agricoles',
    'sous-secteur': 'Maintenance des véhicules et des moeteurs'
  },
];
List<Map<String, dynamic>> diplomesMF = [
  {
    'lib':'BTP','diplome':'Brevet de Technicien Professionnel','durée de formation':'2 ans',"niveau d'admission":'2éme secondaire ou CAP'
  },
  {
    'lib':'BTS','diplome':'Brevet de Technicien Supérieur','durée de formation':'2 ans',"niveau d'admission":'Bac ou BTP'
  },
  {
    'lib':'CAP','diplome':"Certificat d'Aptitude Professionnelle",'durée de formation':'2 ans',"niveau d'admission":'8éme de base ou CC'
  },
  {
    'lib':'CC','diplome':"Certification de Compétence",'durée de formation':'2 ans',"niveau d'admission":'6ème de base'
  }
];
List<String> natureTablissment = [
  'Institut supérieur',
  'Ecole supérieur',
  'Faculté',
  'Ecole primaire',
  'Lycée secondaire',
  'Collège',
  'Centre de formation'
];
List<String> roles = ['Etudiant', 'Eleve', 'Parent', 'Cadre administrative','Enseignant'];
List<String> delegationsRegionales = [
  'Ariana',
  'Béjà',
  'Ben Arous',
  'Bizerte',
  'Gabès',
  'Gafsa',
  'Jendouba',
  'Kairouan',
  'Kasserine',
  'Kébelli',
  'Le Kef',
  'Mahdia',
  'La Mannouba',
  'Médenine',
  'Monastir',
  'Nabeul',
  'Sfax1',
  'Sfax2',
  'Sidi Bouzid',
  'Siliana',
  'Sousse',
  'Tataouine',
  'Tozeur',
  'Tunis1',
  'Tunis2',
  'Zaghouan'
];
List<String> niveauScolaire = [
  'Enseignement de base',
  'Enseignement technique et professionnel',
  'Enseignement secondaire',
  'Enseignement superieur'
];
List<String> statut = [
  'Parent',
  'Apprenant',
  'Enseignant',
  'Etablissement Scolaire'
];
/*
List<Post> postsList = [
  Post(
      communityName: 'LFI1',
      username: 'Ahmed Aziz',
      userAvatar:
          'https://i.pinimg.com/736x/5a/e5/98/5ae598ff624217b9a5c008beb8c512d0.jpg',
      description: 'Interessting',
      postImage:
          'https://res.cloudinary.com/monday-blogs/w_1472,h_1134,c_fit/fl_lossy,f_auto,q_auto/wp-blog/2022/03/simple-customer-profile-template.png'),
  Post(
      communityName: 'LFI1',
      username: 'Ahmed Aziz',
      userAvatar:
          'https://i.pinimg.com/736x/5a/e5/98/5ae598ff624217b9a5c008beb8c512d0.jpg',
      description: 'Interessting',
      postImage:
          'https://res.cloudinary.com/monday-blogs/w_1472,h_1134,c_fit/fl_lossy,f_auto,q_auto/wp-blog/2022/03/simple-customer-profile-template.png'),
  Post(
      communityName: 'LFI1',
      username: 'Ahmed Aziz',
      userAvatar:
          'https://i.pinimg.com/736x/5a/e5/98/5ae598ff624217b9a5c008beb8c512d0.jpg',
      description: 'Interessting',
      postImage:
          'https://res.cloudinary.com/monday-blogs/w_1472,h_1134,c_fit/fl_lossy,f_auto,q_auto/wp-blog/2022/03/simple-customer-profile-template.png'),
  Post(
      communityName: 'LFI1',
      username: 'Ahmed Aziz',
      userAvatar:
          'https://i.pinimg.com/736x/5a/e5/98/5ae598ff624217b9a5c008beb8c512d0.jpg',
      description: 'Interessting',
      postImage:
          'https://res.cloudinary.com/monday-blogs/w_1472,h_1134,c_fit/fl_lossy,f_auto,q_auto/wp-blog/2022/03/simple-customer-profile-template.png'),
  Post(
      communityName: 'LFI1',
      username: 'Ahmed Aziz',
      userAvatar:
          'https://i.pinimg.com/736x/5a/e5/98/5ae598ff624217b9a5c008beb8c512d0.jpg',
      description: 'Interessting',
      postImage:
          'https://res.cloudinary.com/monday-blogs/w_1472,h_1134,c_fit/fl_lossy,f_auto,q_auto/wp-blog/2022/03/simple-customer-profile-template.png'),
  Post(
      communityName: 'LFI1',
      username: 'Ahmed Aziz',
      userAvatar:
          'https://i.pinimg.com/736x/5a/e5/98/5ae598ff624217b9a5c008beb8c512d0.jpg',
      description: 'Interessting',
      postImage:
          'https://res.cloudinary.com/monday-blogs/w_1472,h_1134,c_fit/fl_lossy,f_auto,q_auto/wp-blog/2022/03/simple-customer-profile-template.png'),
  Post(
      communityName: 'LFI1',
      username: 'Ahmed Aziz',
      userAvatar:
          'https://i.pinimg.com/736x/5a/e5/98/5ae598ff624217b9a5c008beb8c512d0.jpg',
      description: 'Interessting',
      postImage:
          'https://res.cloudinary.com/monday-blogs/w_1472,h_1134,c_fit/fl_lossy,f_auto,q_auto/wp-blog/2022/03/simple-customer-profile-template.png'),
  Post(
      communityName: 'LFI1',
      username: 'Ahmed Aziz',
      userAvatar:
          'https://i.pinimg.com/736x/5a/e5/98/5ae598ff624217b9a5c008beb8c512d0.jpg',
      description: 'Interessting',
      postImage:
          'https://res.cloudinary.com/monday-blogs/w_1472,h_1134,c_fit/fl_lossy,f_auto,q_auto/wp-blog/2022/03/simple-customer-profile-template.png'),
  Post(
      communityName: 'LFI1',
      username: 'Ahmed Aziz',
      userAvatar:
          'https://i.pinimg.com/736x/5a/e5/98/5ae598ff624217b9a5c008beb8c512d0.jpg',
      description: 'Interessting',
      postImage:
          'https://res.cloudinary.com/monday-blogs/w_1472,h_1134,c_fit/fl_lossy,f_auto,q_auto/wp-blog/2022/03/simple-customer-profile-template.png'),
];
List<Community> communityList = [
  Community(
      name: 'LFI1',
      imageUrl:
          'https://www.unsw.edu.au/content/dam/images/photos/people/studying-teaching/future-students/2021-06-fs-degree-finder-studying-teaching/066_Computer_Science_Engineering_credit-Anna_Kucera.cropimg.width=335.crop=video.jpg'),
  Community(
      name: 'P3',
      imageUrl:
          'http://www.lanl.gov/org/ddste/aldps/physics/_assets/images/physics-homepage.png'),
  Community(
      name: 'M3',
      imageUrl: 'https://www.ceebd.co.uk/articles/aspects-of-maths.jpg'),
  Community(
      name: 'I3',
      imageUrl: 'https://www.ceebd.co.uk/articles/aspects-of-maths.jpg'),
  Community(
      name: 'RIT1',
      imageUrl:
          'https://images.ctfassets.net/0w27ew15tll3/2pWfTak3DTDQV9QNwdYtMw/fbf576db41e7942d6b52f4062f720cf0/BM2-Mobile-IMG.png'),
];
List<String> elementaryScholl = [
  'Ecole primaire Medjez el-Bab',
  'Ecole primaire Zarzis',
  'Ecole primaire Djerba',
  'Ecole primaire Midoun',
  'Ecole primaire Jedelienne',
  'Ecole primaire Foussana',
  'Ecole primaire Sbiba',
  'Ecole primaire Sbeïtla',
  'Ecole primaire Haïdra',
  'Ecole primaire Ezzouhour',
  'Ecole primaire Fériana',
  'Ecole primaire Thala',
  'Ecole primaire Oueslatia',
  'Ecole primaire Chebika',
  'Ecole primaire Echrarda',
  'Ecole primaire Sbikha',
  'Ecole primaire Oueslatia',
  'Ecole primaire Nasrallah',
  'Ecole primaire Haffouz',
  'Ecole primaire Moularès',
  'Ecole primaire Sened',
  'Ecole primaire Métlaoui',
  'Ecole primaire Mdhilla',
  'Ecole primaire Belkhir',
  'Ecole primaire Redeyef',
  'Ecole primaire Mateur',
  'Ecole primaire Tinja',
  'Ecole primaire Ghezala',
  'Ecole primaire Utique',
  'Ecole primaire Joumine',
  'Ecole primaire Sejnane',
  'Ecole primaire Mateur',
  'Ecole primaire Ras Jebel',
  'Ecole primaire Testour',
  'Ecole primaire Téboursouk',
  'Ecole primaire Amdoun',
  'Ecole primaire Goubellat',
  'Ecole primaire Thibar',
  'Ecole primaire Nefza',
  'Ecole primaire Béja Sud',
]; */
