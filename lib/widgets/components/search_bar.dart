import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

//TODO: Borrar esta clase.
class SearchBar extends StatelessWidget {
  final Function _onChanged;

  SearchBar(this._onChanged);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 37.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26.0),
          color: const Color(0xfff7f7f7),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Row(
            children: <Widget>[
              SvgPicture.string(
                '<svg viewBox="35.5 174.5 19.4 19.4" ><path transform="translate(32.92, 172.56)" d="M 21.33082389831543 18.40301322937012 L 16.74503517150879 14.50273132324219 C 16.27097511291504 14.07608890533447 15.76398086547852 13.88021850585938 15.35442924499512 13.89912509918213 C 16.43693542480469 12.6311092376709 17.09083366394043 10.98606204986572 17.09083366394043 9.188097953796387 C 17.09083366394043 5.17846155166626 13.84040260314941 1.928032040596008 9.830766677856445 1.928032040596008 C 5.821169376373291 1.928032040596008 2.570701599121094 5.17846155166626 2.570701599121094 9.188097953796387 C 2.570701599121094 13.19773387908936 5.821131229400635 16.44816398620605 9.830766677856445 16.44816398620605 C 11.62873077392578 16.44816398620605 13.27377891540527 15.79426670074463 14.54179382324219 14.7117223739624 C 14.52288818359375 15.12127304077148 14.71875762939453 15.62826728820801 15.14540100097656 16.10232543945313 L 19.04570007324219 20.68811798095703 C 19.7135124206543 21.43012046813965 20.80441284179688 21.49266242980957 21.46988105773926 20.82719421386719 C 22.13534736633301 20.16172409057617 22.07284355163574 19.07082557678223 21.33084297180176 18.40301322937012 Z M 9.830766677856445 14.02814292907715 C 7.15770149230957 14.02814292907715 4.990723133087158 11.86116409301758 4.990723133087158 9.18809986114502 C 4.990723133087158 6.515034198760986 7.15770149230957 4.348055362701416 9.830766677856445 4.348055362701416 C 12.50383186340332 4.348055362701416 14.67081069946289 6.515033721923828 14.67081069946289 9.18809986114502 C 14.67081069946289 11.86116409301758 12.50387001037598 14.02814292907715 9.830766677856445 14.02814292907715 Z" fill="#adadad" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                allowDrawingOutsideViewBox: true,
              ),
              Flexible(
                child: TextField(
                  onChanged: _onChanged,
                  style: TextStyle(fontSize: 21),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 10)),
                ),
              )
            ],
          ),
        ));
  }
}
