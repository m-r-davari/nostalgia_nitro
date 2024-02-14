import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {

  final String title;
  final String subtitle;
  final Function onClick;
  final Widget trailing;
  const MenuItem({Key? key,required this.title, required this.subtitle, required this.onClick, required this.trailing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: Material(
        color: Colors.deepPurple.withOpacity(0.05),
        child: InkWell(
          onTap: () => onClick(),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text(title,style: const TextStyle(fontWeight: FontWeight.normal),), Text(subtitle,style: const TextStyle(color: Colors.black54),)],
                ),
                trailing
              ],
            ),
          ),
        ),
      ),
    );
  }
}
