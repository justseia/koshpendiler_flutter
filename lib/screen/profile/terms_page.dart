// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:koshpendiler/core/colors.dart';

String _text = 'Lorem ipsum dolor sit amet. Ab dignissimos quas aut enim '
    'sunt aut eius voluptas et natus animi et unde officiis sit culpa necessitatibus '
    'sit excepturi distinctio.  Ut magni expedita in dolorem rerum qui exercitationem '
    'omnis id odio officia qui vero voluptas. Ab voluptatum voluptates a facilis tempora'
    ' et velit sequi qui quia illo. \n\nSed consectetur illo et tempora dolor ea eius dolor '
    'et nostrum fuga et magni magnam ut unde dolore quo tenetur officia. Qui libero accusamus'
    ' et blanditiis maiores et quis explicabo At repellendus voluptates aut pariatur dolorem. '
    'Et dolores sunt hic quae blanditiis et architecto reiciendis hic doloremque aliquid qui '
    'similique voluptas ex odio exercitationem. Eum voluptatem autem eos pariatur porro aut illo'
    ' voluptatibus? Sed officiis distinctio non dolorem quasi ea labore laudantium non suscipit '
    'accusamus sed corrupti ratione. Et quam nihil et iusto vitae aut odit tempora qui voluptatibus'
    ' magni rem asperiores molestias est galisum quasi. Sit cupiditate eveniet sed quia possimus nam '
    'voluptas magnam sed minus dignissimos qui itaque asperiores. Est alias Quis At cumque Quis a '
    'deserunt minus aut ratione reprehenderit et dicta rerum 33 ipsum tempore. Qui voluptates quos '
    'sed voluptate ratione eum dicta temporibus non ducimus vero eum corporis enim ut impedit '
    'voluptatum in aliquid nemo. \n\nIn aspernatur earum aut fuga facilis ab accusamus quia et quaerat'
    ' rerum sit dolorum suscipit sed quia dolorem. Et illum excepturi id internos natus ut quam '
    'aliquam et velit quia! Id tenetur illum sed minima quae et galisum natus et tenetur dolores'
    ' et repudiandae quibusdam et sunt repudiandae ex nemo aliquid. Rem incidunt nisi non velit '
    'unde id laudantium voluptatum in quis adipisci et error incidunt est veritatis harum. Et '
    'voluptatem atque ut dolorem perferendis et dolore tempora eum officiis culpa. \n\nLorem ipsum'
    ' dolor sit amet. Ex galisum odio nam voluptatem nostrum et similique corporis aut modi '
    'quidem est magni accusamus. Qui iste incidunt aut aperiam quia ut sunt sint ut sunt magni '
    'est porro dolores. Est itaque internos sed quas quae eos repellendus temporibus At quibusdam '
    'consequatur qui autem minus. Qui minima autem vel officiis quaerat At omnis deleniti id deleniti '
    'fugit. Qui veritatis asperiores in asperiores voluptates ut sapiente numquam qui laboriosam '
    'reiciendis. Aut expedita consequatur rem voluptatem quia ut quasi quos eum fugiat doloremque '
    'qui eligendi ipsum et vero quae. Aut veritatis libero ex enim magni non nostrum soluta qui '
    'eaque veritatis. \n\nVel perferendis sequi et error itaque et dolore corporis qui vero nemo hic'
    ' rerum laboriosam et voluptatibus odit. Aut consequuntur dolorum et mollitia iste ea voluptas '
    'dolore et quibusdam minus ut dolorum obcaecati non incidunt iste vel cumque illum! Sed consequatur '
    'necessitatibus nam enim sequi aut blanditiis eaque! Vel delectus ipsam est quos nostrum qui '
    'veniam reprehenderit. Aut enim enim eum temporibus quibusdam aut rerum animi est minima iste. '
    'Sed animi minus id quia delectus est voluptas distinctio quo itaque ratione. Est illo repellat '
    'aut omnis amet aut quia sequi et error facilis est tempora architecto est perspiciatis velit.'
    ' \n\nEt galisum voluptas ex nisi aliquid sed neque blanditiis! Non officiis ipsa non galisum '
    'tempora aut iusto autem et ratione voluptas ut necessitatibus sunt sit laudantium voluptates? '
    '33 omnis modi aut accusamus neque est illo repellendus et enim dolores et maxime tempora!';

class TermsPage extends StatefulWidget {
  const TermsPage({super.key});

  @override
  State<TermsPage> createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage> {
  double maxWidth(BuildContext context) => MediaQuery.of(context).size.width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Container(
                height: 1,
                width: maxWidth(context) - 44,
                margin: EdgeInsets.symmetric(vertical: 20),
                color: ColorsApp.yellowbd,
              ),
              SizedBox(
                width: maxWidth(context) - 44,
                child: Text(
                  _text,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    height: 16.94 / 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Colors.black,
      title: Text(
        'Terms & Conditions',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          height: 25.63 / 22,
        ),
      ),
    );
  }
}
