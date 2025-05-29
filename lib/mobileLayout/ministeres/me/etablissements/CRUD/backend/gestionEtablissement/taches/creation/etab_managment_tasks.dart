class etabTasksCreate {
//*************************************Presentation************************************** */
  void etabPresentation(String natureEtab, String delagation, String typeEtab,
      String description, String logo, List galerie) async {}

//************************************Adresses*********************************************** */
  void etabAdresses(
      String adresse, String telFax, String email, String siteweb) async {}
//********************************Bloc/departement*************************** */
  void etabBlocDepartement(String lib, List galerie) async {}
//****************************************Salles******************************************** */
  void etabSalles(String blocDepart, String libSalle, List galerie) async {}
//********************************resources humaines**************************** */
  void etabRH(String cadre, String poste) async {}
//*****************************************************Services************************* */
  void etabServices(bool foyer, List galerieFoyer, bool restaurant,
      List galerieResto, List transports) async {}
//******************************************Clubs************************************** */
  void etabClubs(String lib, String description, List galerie) async {}
}
