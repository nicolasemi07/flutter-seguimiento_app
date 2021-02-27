part of 'widgets.dart';

class SearchBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (context, state) {
        if (state.seleccionManual) {
          return Container();
        } else {
          return FadeInDown(
            duration: Duration(milliseconds: 300),
            child: buildSearchBar(context)
          );
        }
      },
    );
  }

  Widget buildSearchBar(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: width,
      child: GestureDetector(
        onTap: () async {
          final resultado = await showSearch(context: context, delegate: SearchDestination());
          this.retornoBusqueda(context, resultado);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
          width: double.infinity,
          child: Text('¿Dónde querés ir?', style: TextStyle(color: Colors.black87 )),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100),
            boxShadow: [ BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0,5)) ]
          ),
        ),
      )
    );
  }

  void retornoBusqueda(BuildContext context, SearchResult result) {
    if (result.cancelo) return;
    if (result.manual) {
      BlocProvider.of<BusquedaBloc>(context).add(OnActivarMarcadorManual());
      return;
    }
  }

}