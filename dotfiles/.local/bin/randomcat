#!/usr/bin/env bash

cats=(); cat() { read -rd '' cat; cats+=("$cat"); }

# unknown/disputed authorship
cat <<'cat'
     \`"-.
      )  _`-.
     ,  : `. \
     : _   '  \
     ; *` _.   `--._
     `-.-'          `-.
       |       `       `.
       :.       .        \
       | \  .   :   .-'   .
       :  )-.;  ;  /      :
       :  ;  | :  :       ;-.
       ; /   : |`-:     _ `- )
🐞  ,-' /  ,-' ; .-`- .' `--'
    `--'   `---' `---'
cat
cat <<'cat'
                        _
                       | \
                       | |
                       | |
  |\                   | |
 /, ~\                / /
X     `-.....-------./ /
 ~-. ~  ~              |
    \             /    |
     \  /_     ___\   /
     | /\ ~~~~~   \ |
     | | \        || |
     | |\ \       || )
    (_/ (_/      ((_/
cat
cat <<'cat'
   |\---/|
   | ,_, |
    \_`_/-..----.
 ___/ `   ' ,""+ \
(__...'   __\    |`.___.';
  (_,...'(_,.`__)/'.....+
cat
cat <<'cat'
            meow
  ／l、
（ﾟ､｡ ７
  l、ﾞ~ヽ
  じしf_,)ノ
cat
cat <<'cat'
             ＿＿
         ／＞     フ
        |   +  +  |
       ／` ミ⯆ ミノ
      /          |
     /   ヽ     ﾉ
    │     |  |  |
／￣|     |  |  |
| (￣ヽ＿_ヽ_)__)
＼二つ
cat
# bf
cat <<'cat'
 _._     _,-'""`-._
(,-.`._,'(       |\`-/|
    `-.-' \ )-`( , o o)
          `-    \`_`"'-
cat
# Hayley Jane Wakenshaw
cat <<'cat'
        _..---...,""-._     ,/}/)
     .''        ,      ``..'(/-<
    /   _      {      )         \
   ;   _ `.     `.   <         a(
 ,'   ( \  )      `.  \ __.._ .: y
(  <\_-) )'-.____...\  `._   //-'
 `. `-' /-._)))      `-._)))                🐛
   `...'
cat
# jgs
cat <<'cat'
                  __     __,
                  \,`~"~` /
  .-=-.           /    . .\
 / .-. \          {  =    Y}=
(_/   \ \          \      /
       \ \        _/`'`'`b
        \ `.__.-'`        \-._
         |            '.__ `'-;_
         |            _.' `'-.__)
          \    ;_..--'/     //  \
          |   /  /   |     //    |
          \  \ \__)   \   //    /
           \__)        './/   .'
                         `'-'`
cat
# jgs
cat <<'cat'
         .-o=o-.
     ,  /=o=o=o=\ .--.
    _|\|=o=O=o=O=|    \
__.'  a`\=o=o=o=(`\   /
'.   a 4/`|.-""'`\ \ ;'`)   .---.
  \   .'  /   .--'  |_.'   / .-._)
   `)  _.'   /     /`-.__.' /
    `'-.____;     /'-.___.-'
             `"""`
cat
# jgs
cat <<'cat'
 /\___/\
 )     (
=\     /=
  )   (
 /     \
 )     (
/       \
\       /
 \__ __/
    ))
   //
  ((
   \)
cat
# jrei
cat <<'cat'
                  .-.
                   \ \
                    \ \
                     | |
                     | |
   /\---/\   _,---._ | |
  /^   ^  \,'       `. ;
 ( O   O   )           ;
  `.=ω=__,'            \
    /         _,--.__   \
   /  _ )   ,'   `-. `-. \
  / ,' /  ,'        \ \ \ \
 / /  / ,'          (,_)(,_)
(,;  (,,)
cat
# Felix Lee
cat <<'cat'
        _,'|             _.-''``-...___..--';)
       /_ \'.      __..-' ,      ,--...--'''
      <\    .`--'''       `     /'
       `-';'               ;   ; ;
 __...--''     ___...--_..'  .;.'
(,__....----'''       (,..--''
cat
# Felix Lee
cat <<'cat'
💤  |\      _,,,---,,_
 💤 /,`.-'`'    -.  ;-;;,_
   |,4-  ) )-,_..;\ (  `'-'
  '---''(_/--'  `-'\_)
cat
# Felix Lee
cat <<'cat'
             )\._.,--....,'``.
🦋          /,   _.. \   _\  (`._ ,.
           `._.-(,_..'--(,_..'`-.;.'
cat
cat <<'cat'
               )\._.,--....,'``.
 .b--.        /;   _.. \   _\  (`._ ,.
`=,-,-'~~~   `----(,_..'--(,_..'`-.;.'
cat
# Felix Lee
cat <<'cat'
              __..--''``---....___   _..._    __
    /// //_.-'    .-/";  `        ``<._  ``.''_ `. / // /
   ///_.-' _..--.'_    \                    `( ) ) // //
   / (_..-' // (< _     ;_..__               ; `' / ///
    / // // //  `-._,_)' // / ``--...____..-' /// / //
cat
cat <<'cat'
           __..--''``\--....___   _..,_
       _.-'    .-/";  `        ``<._  ``-+'~=.
   _.-' _..--.'_    \                    `(^) )
  ((..-'    (< _     ;_..__               ; `'
             `-._,_)'      ``--...____..-'
cat
cat=${cats[$RANDOM % ${#cats[@]}]}
c=$((1+ RANDOM % ($(stty size | cut -d' ' -f2) - $(wc -L <<<"$cat") - 2)))
# did you know that wc -L correctly handles wide unicode characters?

# hehe, never used coreutils nl before
echo -e "\n$cat\n" | nl -bn -w $c

# coreutils pr is even more esoteric i feel like
# echo -e "\n$cat\n" | pr -to $c

# also did you know that the bash builtin `read` strips leading whitepspace?
# guess how I got it to Stop doing that :P

# ASCII cat sources:
# https://www.asciiart.eu/animals/cats
# https://user.xmission.com/~emailbox/ascii_cats.htm
# https://web.archive.org/web/20220118023343/http://www.oocities.org/spunk1111/pets.htm
# (also check out https://user.xmission.com/~emailbox/graphics.htm !)
# https://4-ch.net/ascii/kareha.pl/1135896068/
# in ^ i really liked the ones of the cat going bap and getting spooked, but
# it uses a proportional font and I had a hard time making them look even
# half as good in monospace :( i'll take another crack at them someday
#
# ... and various reddit replies, steam profile comments, etc.
