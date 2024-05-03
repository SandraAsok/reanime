import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:reanime/anime/onepiece.dart';
import 'package:reanime/wishlist/wishlist.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Text(
          'REANIME',
          style: TextStyle(color: Colors.black87, fontSize: 22.5),
        ),
        backgroundColor: Colors.orangeAccent,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => wishlist(),
                      ));
                },
                icon: Icon(
                  Icons.favorite_outline_rounded,
                  color: Colors.black87,
                )),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Popular..',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
            ),
            CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 0.5,
                animateToClosest: true,
                padEnds: false,
                clipBehavior: Clip.hardEdge,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 2),
                height: 200,
                scrollDirection: Axis.horizontal,
              ),
              items: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => op(
                                anime: 'one piece',
                                image: "lib/asset/onep.jpg",
                                title: "About One piece",
                                detail:
                                    "One Piece is a Japanese manga series written and illustrated by Eiichiro Oda. It has been serialized in Shueisha\'s shōnen manga magazine Weekly Shōnen Jump since July 1997, with its individual chapters compiled in 107 tankōbon volumes as of November 2023. The story follows the adventures of Monkey D. Luffy and his crew, the Straw Hat Pirates, where he explores the Grand Line in search of the mythical treasure known as the \"One Piece\" in order to become the next King of the Pirates."),
                          ));
                    },
                    child: Container(
                      child: Image.asset("lib/asset/onep.jpg"),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => op(
                                anime: 'naruto',
                                image: 'lib/asset/naru.jpg',
                                title: 'About Naruto',
                                detail:
                                    'Naruto is a Japanese manga series written and illustrated by Masashi Kishimoto. It tells the story of Naruto Uzumaki, a young ninja who seeks recognition from his peers and dreams of becoming the Hokage, the leader of his village. The story is told in two parts: the first is set in Naruto\'s pre-teen years (volumes 1–27), and the second in his teens (volumes 28–72). The series is based on two one-shot manga by Kishimoto: Karakuri (1995), which earned Kishimoto an honorable mention in Shueisha\'s monthly Hop Step Award the following year, and Naruto (1997).'),
                          ));
                    },
                    child: Container(
                      child: Image.asset('lib/asset/naru.jpg'),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => op(
                                anime: 'deathnote',
                                image: 'lib/asset/dn.jpg',
                                title: 'About Death Note',
                                detail:
                                    'Death Note is a Japanese manga series written by Tsugumi Ohba and illustrated by Takeshi Obata. It was serialized in Shueisha\'s shōnen manga magazine Weekly Shōnen Jump from December 2003 to May 2006, with its chapters collected in 12 tankōbon volumes. The story follows Light Yagami, a genius high school student who discovers a mysterious notebook: the "Death Note", which belonged to the shinigami Ryuk, and grants the user the supernatural ability to kill anyone whose name is written in its pages. The series centers around Light\'s subsequent attempts to use the Death Note to carry out a worldwide massacre of individuals whom he deems immoral and to create a crime-free society, using the alias of a god-like vigilante named "Kira", and the subsequent efforts of an elite Japanese police task force, led by enigmatic detective L, to apprehend him.'),
                          ));
                    },
                    child: Container(
                      child: Image.asset('lib/asset/dn.jpg'),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => op(
                                anime: 'attack on titan',
                                image: 'lib/asset/aot.jpg',
                                title: 'About Attack on Titan',
                                detail:
                                    'Attack on Titan is a Japanese manga series written and illustrated by Hajime Isayama. It is set in a world where humanity is forced to live in cities surrounded by three enormous walls that protect them from gigantic man-eating humanoids referred to as Titans; the story follows Eren Yeager, who vows to exterminate the Titans after they bring about the destruction of his hometown and the death of his mother. It was serialized in Kodansha\'s monthly magazine Bessatsu Shōnen Magazine from September 2009 to April 2021, with its chapters collected in 34 tankōbon volumes.'),
                          ));
                    },
                    child: Container(
                      child: Image.asset('lib/asset/aot.jpg'),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => op(
                                anime: '',
                                image: 'lib/asset/db.jpg',
                                title: 'About Dragon Ball',
                                detail:
                                    'Dragon Ball is a Japanese media franchise created by Akira Toriyama in 1984. The initial manga, written and illustrated by Toriyama, was serialized in Weekly Shōnen Jump from 1984 to 1995, with the 519 individual chapters collected in 42 tankōbon volumes by its publisher Shueisha. Dragon Ball was originally inspired by the classical 16th-century Chinese novel Journey to the West, combined with elements of Hong Kong martial arts films. Dragon Ball characters also use a variety of East Asian martial arts styles, including karate and Wing Chun (kung fu). The series follows the adventures of protagonist Son Goku from his childhood through adulthood as he trains in martial arts. He spends his childhood far from civilization until he meets a teen girl named Bulma, who encourages him to join her quest in exploring the world in search of the seven orbs known as the Dragon Balls, which summon a wish-granting dragon when gathered. Along his journey, Goku makes several other friends, becomes a family man, discovers his alien heritage, and battles a wide variety of villains, many of whom also seek the Dragon Balls.'),
                          ));
                    },
                    child: Container(
                      child: Image.asset('lib/asset/db.jpg'),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Recomended..',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
            ),
            CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 0.5,
                animateToClosest: true,
                padEnds: false,
                clipBehavior: Clip.hardEdge,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 2),
                height: 200,
                scrollDirection: Axis.horizontal,
              ),
              items: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => op(
                                anime: 'jojos bizzare adventure',
                                image: 'lib/asset/jojo.jpg',
                                title: 'About JoJo\'s Bizarre Adventure',
                                detail:
                                    'JoJo\'s Bizarre Adventure  is a Japanese manga series written and illustrated by Hirohiko Araki. It was originally serialized in Shueisha\'s shōnen manga magazine Weekly Shōnen Jump from 1987 to 2004, and was transferred to the monthly seinen manga magazine Ultra Jump in 2005. The series is so far divided into a total of nine story arcs, each following a new protagonist bearing the "JoJo" nickname. JoJo\'s Bizarre Adventure is the largest ongoing manga series published by Shueisha by number of volumes, with its chapters collected in 133 tankōbon volumes as of December 2023.'),
                          ));
                    },
                    child: Container(
                      child: Image.asset('lib/asset/jojo.jpg'),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => op(
                                anime: 'bleach',
                                image: 'lib/asset/Bleach.webp',
                                title: 'About Bleach',
                                detail:
                                    'Bleach is a Japanese anime television series based on Tite Kubo\'s original manga series of the same name. It was produced by Studio Pierrot and directed by Noriyuki Abe. The series aired on TV Tokyo from October 2004 to March 2012, spanning 366 episodes. The story follows the adventures of Ichigo Kurosaki after he obtains the powers of a Soul Reaper—a death personification similar to the Grim Reaper—from another Soul Reaper, Rukia Kuchiki. His newfound powers force him to take on the duties of defending humans from evil spirits and guiding departed souls to the afterlife. In addition to adapting the manga series it is based on, the anime periodically includes original self-contained storylines and characters not found in the source material.'),
                          ));
                    },
                    child: Container(
                      child: Image.asset('lib/asset/Bleach.webp'),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => op(
                                anime: 'jujutsu kaisen',
                                image: 'lib/asset/jjk.jpg',
                                title: 'About Jujutsu Kaisen',
                                detail:
                                    'Jujutsu Kaisen is a Japanese manga series written and illustrated by Gege Akutami. It has been serialized in Shueisha\'s shōnen manga magazine Weekly Shōnen Jump since March 2018, with its chapters collected and published in 25 tankōbon volumes as of January 2024. The story follows high school student Yuji Itadori as he joins a secret organization of Jujutsu Sorcerers to eliminate a powerful Curse named Ryomen Sukuna, of whom Yuji becomes the host. Jujutsu Kaisen is a sequel to Akutami\'s Tokyo Metropolitan Curse Technical School, serialized in Shueisha\'s Jump Giga from April to July 2017, later collected in a tankōbon volume, retroactively titled as Jujutsu Kaisen 0, in December 2018'),
                          ));
                    },
                    child: Container(
                      child: Image.asset('lib/asset/jjk.jpg'),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => op(
                                anime: 'solo leveling',
                                image: 'lib/asset/solo.jpg',
                                title: 'About Solo Leveling',
                                detail:
                                    'Solo Leveling, also alternatively translated as Only I Level Up (Korean: 나 혼자만 레벨업; RR: Na Honjaman Rebeleop), is a South Korean web novel written by Chugong. It was serialized in Kakao\'s digital comic and fiction platform KakaoPage beginning on July 25, 2016, and was later published in by D&C Media under their Papyrus label since November 4, 2016. The novel has been licensed in English by Yen Press.[1]'),
                          ));
                    },
                    child: Container(
                      child: Image.asset('lib/asset/solo.jpg'),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => op(
                                anime: "demon slayer",
                                image: 'lib/asset/ds.jpg',
                                title: 'About Demon Slayer',
                                detail:
                                    'Demon Slayer: Kimetsu no Yaiba (鬼滅の刃, Kimetsu no Yaiba, rgh. "Blade of Demon Destruction")[4] is a Japanese manga series written and illustrated by Koyoharu Gotouge. It was serialized in Shueisha\'s shōnen manga magazine Weekly Shōnen Jump from February 2016 to May 2020, with its chapters collected in 23 tankōbon volumes. It has been published in English by Viz Media and simultaneously on the Manga Plus platform by Shueisha. It follows teenage Tanjiro Kamado, who strives to become a Demon Slayer after his family was slaughtered and his younger sister, Nezuko, is turned into a demon.'),
                          ));
                    },
                    child: Container(
                      child: Image.asset('lib/asset/ds.jpg'),
                    ),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text(
                'More..',
                style: TextStyle(color: Colors.white),
              ),
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    viewportFraction: 0.5,
                    animateToClosest: true,
                    padEnds: false,
                    clipBehavior: Clip.hardEdge,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 2),
                    height: 200,
                    scrollDirection: Axis.horizontal,
                  ),
                  items: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => op(
                                        anime: 'naruto shippuden',
                                        image: 'lib/asset/naruship.jpg',
                                        title: 'About naruto: Shippuden',
                                        detail:
                                            'Naruto: Shippuden is an anime television series mainly adapted from Part II of Masashi Kishimoto\'s original Naruto manga series, with exactly 500 episodes. It is set two and a half years after the original series in the Naruto universe, following the teenage ninja Naruto Uzumaki and his allies. The series is directed by Hayato Date, and produced by Pierrot and TV Tokyo. It began broadcasting on February 15, 2007, on TV Tokyo, and concluded on March 23, 2017',
                                      )));
                        },
                        child: Container(
                          child: Image.asset('lib/asset/naruship.jpg'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => op(
                                  anime: 'one punch man',
                                  image: 'lib/asset/opm.webp',
                                  title: 'About One Punch Man',
                                  detail:
                                      'One-Punch Man  is a Japanese superhero manga series created by One. It tells the story of Saitama, a superhero who, because he can defeat any opponent with a single punch, grows bored from a lack of challenge. One wrote the original webcomic manga version in early 2009.',
                                ),
                              ));
                        },
                        child: Container(
                          child: Image.asset('lib/asset/opm.webp'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => op(
                                  anime: 'hunter x hunter',
                                  image: 'lib/asset/hxh.jpg',
                                  title: 'About Hunter × Hunter',
                                  detail:
                                      'Hunter × Hunter  is a Japanese manga series written and illustrated by Yoshihiro Togashi. It has been serialized in Shueisha\'s shōnen manga magazine Weekly Shōnen Jump since March 1998, although the manga has frequently gone on extended hiatuses since 2006. Its chapters have been collected in 37 tankōbon volumes as of November 2022. The story focuses on a young boy named Gon Freecss who discovers that his father, who left him at a young age, is actually a world-renowned Hunter, a licensed professional who specializes in fantastical pursuits such as locating rare or unidentified animal species, treasure hunting, surveying unexplored enclaves, or hunting down lawless individuals. Gon departs on a journey to become a Hunter and eventually find his father. Along the way, Gon meets various other Hunters and encounters the paranormal.',
                                ),
                              ));
                        },
                        child: Container(
                          child: Image.asset('lib/asset/hxh.jpg'),
                        ),
                      ),
                    ),
                  ],
                ),
                CarouselSlider(
                  options: CarouselOptions(
                    viewportFraction: 0.5,
                    animateToClosest: true,
                    padEnds: false,
                    clipBehavior: Clip.hardEdge,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 2),
                    height: 200,
                    scrollDirection: Axis.horizontal,
                  ),
                  items: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => op(
                                  anime: 'parasyte',
                                  image: 'lib/asset/para.jpg',
                                  title: 'About ',
                                  detail:
                                      'Parasyte is a Japanese science fiction horror manga series written and illustrated by Hitoshi Iwaaki. It was published in Kodansha\'s Morning Open Zōkan (1989) and Monthly Afternoon (1989 to 1994). The manga was published in North America first by Tokyopop, then Del Rey, and finally Kodansha USA. The series follows Shinichi Izumi, a high school senior who is the victim of a failed attempt by a parasitic organism to take over his brain. The parasite instead infects and takes over his arm.',
                                ),
                              ));
                        },
                        child: Container(
                          child: Image.asset('lib/asset/para.jpg'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => op(
                                  anime: 'boruto',
                                  image: 'lib/asset/bor.jpg',
                                  title: 'About Boruto',
                                  detail:
                                      'Boruto is a Japanese manga series written by Ukyō Kodachi and Masashi Kishimoto, and illustrated by Mikio Ikemoto. It initially began monthly serialization under the title Boruto: Naruto Next Generations,with Kodachi as writer and Kishimoto as editorial supervisor in Shueisha\'s shōnen manga magazine Weekly Shōnen Jump in May 2016, and was transferred to Shueisha\'s monthly magazine V Jump in July 2019. In November 2020, Kodachi stepped down, with Kishimoto taking over as writer. In April 2023, the series concluded the first part of the story and, following a brief hiatus, continued in August of the same year with a second part titled Boruto: Two Blue Vortex. Boruto is a spin-off and a sequel to Kishimoto\'s Naruto and follows the exploits of Naruto Uzumaki\'s son, Boruto Uzumaki, and his ninja team.',
                                ),
                              ));
                        },
                        child: Container(
                          child: Image.asset('lib/asset/bor.jpg'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => op(
                                  anime: 'chainsaw man',
                                  image: 'lib/asset/csm.jpg',
                                  title: 'About Chainsaw Man',
                                  detail:
                                      'Chainsaw Man is a Japanese manga series written and illustrated by Tatsuki Fujimoto. Its first arc was serialized in Shueisha\'s shōnen manga magazine Weekly Shōnen Jump from December 2018 to December 2020; its second arc began serialization in Shueisha\'s Shōnen Jump+ app and website in July 2022. Its chapters have been collected in 16 tankōbon volumes as of December 2023.',
                                ),
                              ));
                        },
                        child: Container(
                          child: Image.asset('lib/asset/csm.jpg'),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
