import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/chached_net_image.dart';

class StatiComment extends StatefulWidget {
  const StatiComment(
      {Key? key,
      required this.rating,
      required this.name,
      required this.comment,
      required this.imageURl})
      : super(key: key);
  final String rating;
  final String name;
  final String comment;
  final String imageURl;
  @override
  State<StatiComment> createState() => _StatiCommentState();
}

class _StatiCommentState extends State<StatiComment> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(90),
                  child: CachedNetworkImage(
                    height: 48.66666666666667,
                    width: 49,
                    imageUrl: widget.imageURl,
                    fit: BoxFit.cover,
                  )),
              const SizedBox(
                width: 14.33333333333333,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Color(0xFFe21a37),
                        size: 12.66666666666667,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        widget.rating,
                        style: GoogleFonts.montserrat(
                            fontSize: 11.51, color: const Color(0xFF919191)),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    widget.name,
                    style: GoogleFonts.montserrat(
                      color: const Color(0xFF474747),
                      fontSize: 15.65333333333333,
                    ),
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            height: 12.66666666666667,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.comment,
                style: GoogleFonts.montserrat(),
              )),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            height: 5,
            thickness: 2,
            color: Color(0xFFe5e5e5),
          )
        ],
      ),
    );
  }
}
