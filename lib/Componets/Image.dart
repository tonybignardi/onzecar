import 'package:flutter/cupertino.dart';

// componente de imagem
class Image_Wiget extends StatelessWidget{
  const Image_Wiget({
    super.key,
    required this.link
  });
  final String link;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.network(
        link,
        height: 100,
        fit: BoxFit.contain,
      ),
    );
  }
}
