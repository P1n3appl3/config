# https://getrssfeed.com
# ... or https://pypi.org/project/feed-seeker
# ... or https://www.jvt.me/posts/2022/06/19/cli-feed-discovery
(map (l: { title=builtins.head l; feed=builtins.elemAt l 2;
  url=let s=builtins.elemAt l 1;in if builtins.substring 0 4 s == "http"
  then s else "https://" + s; }) [
["Jade"               "jade.fyi"                            "/rss.xml"]
["Julia Evans"        "jvns.ca"                             "/atom.xml"]
["Joy of Computing"   "joy.recurse.com"                     "/feed.atom"]
["quiet misdreavus"   "quietmisdreavus.net"                 "/feed.xml"]
["Hillel Wayne"       "www.hillelwayne.com"                 "/index.xml"]
["Computer Things"    "buttondown.email/hillelwayne"        "/rss"]
["B. Ciechanowski"    "ciechanow.ski"                       "/atom.xml"]
["Cassie"             "blog.witchoflight.com"               "/feed.xml"]
["PhobosLab"          "www.phoboslab.org/log"               "/feed"]
["matklad"            "matklad.github.io"                   "/feed.xml"]
["Kyle Halladay"      "kylehalladay.com"                    "/atom.xml"]
["Stephen Marz"       "blog.stephenmarz.com"                "/feed"]
["Phil Oppermann"     "os.phil-opp.com"                     "/rss.xml"]
["Rodrigo Copetti"    "www.copetti.org"                     "/index.xml"]
["Nora Codes"         "nora.codes"                          "/index.xml"]
["WesleyAC"           "blog.wesleyac.com"                   "/feed.xml"]
["Me"                 "julia.blue"                          "/feed.xml"]
["Chris Fallin"       "cfallin.org"                         "/feed.xml"]
["J Haigh"            "optimistictypes.com"                 "/feed.xml"]
["TWiR"               "this-week-in-rust.org"               "/rss.xml"]
["Jorge Aparicio"     "http://blog.japaric.io"              "/index.xml"]
["Rust Blog"          "blog.rust-lang.org"                  "/feed.xml"]
["Bryan Cantrill"     "bcantrill.dtrace.org"                "/index.xml"]
["Red Blob Games"     "www.redblobgames.com"                "/blog/posts.xml"]
["Brendan Gregg"      "www.brendangregg.com/blog"           "/rss.xml"]
["Graydon"            "graydon2.dreamwidth.org"             "/data/rss"]
["Aphyr"              "aphyr.com"                           "/posts.atom"]
["Nick Cameron"       "www.ncameron.org/blog"               "/rss"]
["Llogiq"             "llogiq.github.io"                    "/feed.xml"]
["Two-Bit History"    "twobithistory.org"                   "/feed.xml"]
["Seena Burns"        "seenaburns.com"                      "/feed.xml"]
["Eli Bendersky"      "eli.thegreenplace.net"               "/feeds/all.atom.xml"]
["Steve Klabnik"      "steveklabnik.com"                    "/feed.xml"]
["Aaron Turon"        "http://aturon.github.io"             "/atom.xml"]
["Ken Shirriff"       "http://www.righto.com"               "/feeds/posts/default"]
["null program"       "nullprogram.com"                     "/feed"]
["Coding Horror"      "blog.codinghorror.com"               "/rss"]
["Jynn"               "jyn.dev"                             "/atom.xml"]
["the6p4c"            "the6p4c.github.io"                   "/posts.xml"]
["David Koloski"      "david.kolo.ski"                      "/atom.xml"]
["Tom7"               "http://tom7.org"                     "/f/a/weblog/rss/1"]
["Tristan Hume"       "thume.ca"                            "/atom.xml"]
["Bodil Stokke"       "bodil.lol"                           "/atom.xml"]
["Mitxela"            "mitxela.com"                         "/feed"]
["Artemis Everfree"   "artemis.sh"                          "/feed.xml"]
["sdomi"              "http://sdomi.pl"                     "/weblog/atom"]
["n-o-d-e"            "n-o-d-e.net"                         "/rss/rss.xml"]
["Ellie"              "ellie.wtf"                           "/index.xml"]
["Manish"             "manishearth.github.io"               "/feed"]
["mcyoung"            "mcyoung.xyz"                         "/feed"]
["mangopdf"           "mango.pdf.zone"                      "/feed"]
["Alyssa Rosenzweig"  "rosenzweig.io"                       "/feed.xml"]
["Rain"               "sunshowers.io"                       "/index.xml"]
["Amos"               "fasterthanli.me"                     "/index.xml"]
["JeanHeyd Meneide"   "thephd.dev"                          "/feed.xml"]
["Waffle"             "blog.ihatereality.space"             "/rss.xml"]
["Travis Downs"       "travisdowns.github.io"               "/feed.xml"]
["Mara"               "blog.m-ou.se"                        "/index.xml"]
["Guillaume Gomez"    "blog.guillaume-gomez.fr"             "/atom"]
["Gary Bernhardt"     "www.destroyallsoftware.com"          "/blog/index.xml"]
["Remzi A-D"          "http://from-a-to-remzi.blogspot.com" "/feeds/posts/default"]
["Cliff Biffle"       "cliffle.com"                         "/rss.xml"]
["Mohit Bhoite"       "www.bhoite.com"                      "/feed"]
["Bob Nystrom"        "journal.stuffwithstuff.com"          "/rss.xml"]
["There oughta be"    "there.oughta.be"                     "/feed.xml"]
["Lord"               "lord.io"                             "/feed.xml"]
["Mozilla Hacks"      "hacks.mozilla.org"                   "/feed"]
["Nick Fitzgerald"    "fitzgeraldnick.com"                  "/feed.xml"]
["aki"                "lethalbit.net"                       "/atom.xml"]
["Greg Davill"        "gregdavill.com"                      "/index.xml"]
["Annie Cherkaev"     "anniecherkaev.com"                   "/feed.xml"]
["Whitequark"         "lab.whitequark.org"                  "/atom.xml"]
["ridiculousfish"     "ridiculousfish.com"                  "/blog/atom.xml"]
["Quil"               "robotlolita.me"                      "/atom.xml"]
["Raph Levien"        "raphlinus.github.io"                 "/feed.xml"]
["Tyler Mandry"       "tmandry.gitlab.io/blog"              "/index.xml"]
["David Lemire"       "lemire.me/blog"                      "/feed"]
["Gankra"             "gankra.github.io"                    "/blah/rss.xml"]
["Jane"               "yaah.dev"                            "/feed.xml"]
["Dan Luu"            "danluu.com"                          "/atom.xml"]
["boats"              "without.boats"                       "/index.xml"]
["StefanSF"           "stefansf.de"                         "/feed.xml"]
["John Regehr"        "blog.regehr.org"                     "/feed"]
["Josh Haberman"      "blog.reverberate.org"                "/feed.xml"]
["Matt Keeter"        "mattkeeter.com"                      "/atom.xml"]
["Niko Matsakis"      "smallcultfollowing.com/babysteps"    "/atom.xml"]
["Francesco Mazzoli"  "mazzo.li"                            "/rss.xml"]
["Dennis Schubert"    "overengineer.dev"                    "/blog/feeds/all.xml"]
["Ben Fredrickson"    "http://www.benfrederickson.com"      "/atom.xml"]
["Susam Pal"          "susam.net"                           "/blog/feed.xml"]
["Serge Zaitsev"      "zserge.com"                          "/rss.xml"]
["Sadgrl"             "sadgrl.online"                       "/feed.xml"]
["Cadence"            "cadence.moe"                         "/blog/rss.xml"]
["Bunnie Studios"     "www.bunniestudios.com"               "/blog/?feed=rss2"]
["Alona"              "alona.page"                          "/index.xml"]
["MaskRay"            "maskray.me"                          "/blog/atom.xml"]
["Justine Tunney"     "justine.lol"                         "/rss.xml"]
["Eevee"              "eev.ee/blog"                         "https://eev.ee/feeds/atom.xml"]
["Ashley Williams"    "medium.com/@ag_dubs"                 "https://medium.com/feed/@ag_dubs"]
["Ludicity"           "ludic.mataroa.blog"                  "/rss"]
["Chevy Ray"          "chevyray.dev"                        "/rss.xml"]
["myrrlyn"            "myrrlyn.net/blog"                    "/atom.xml"]
["Julien"             "oneirical.github.io"                 "/atom.xml"]
["hikari"             "hikari.noyu.me"                      "/blog"]
["nora"               "noratrieb.dev"                       "/blog/index.xml"]
["Jonathan"           "donsz.nl"                            "/rss.xml"]
["rebecca"            "becca.ooo"                           "/rss.xml"]
["Ella"               "ectcetera.net/blog"                  "/atom.xml"]
["ash"                "catgirl.ai"                          "/log/atom.xml"]
["Alejandra González" "blog.goose.love"                     "/index.xml"]
["dropbear"           "dropbear.sh"                         "https://julia.blue/allyrss.xml"]
["Luna"               "moonbase.lgbt"                       "/blog/atom.xml"]
["Charlotte"          "char.lt"                             "/blog.rss"]
["mbuffett"           "mbuffett.com"                        "/posts/index.xml"]
["Saron Yitbarek"     "notadesigner.io"                     "https://rss.beehiiv.com/feeds/uyO6uKaqK0.xml"]
["100 rabbits"        "100r.co"                             "/links/rss.xml"]
["aoife cassidy"      "enby.space"                          "/writing/index.xml"
["Imran Nazar"        "imrannazar.com"                      "/rss.xml"]
["Fabien Sanglard"    "fabiensanglard.net"                  "/rss.xml"]
["Alex Chan"          "alexwlchan.net"                      "/atom.xml"]

# ["Julia Violet"       "juliaviolet.dev"                     "N/A"]
# ["nan.fyi"            "nan.fyi"                             "???"]

# TODO: parse yyyy-mm-dd dates
["Peter Norvig"      "http://www.norvig.com"               "/rss-feed.xml"]

# TODO: handle "Z" for timezone in 2822 date
["computers are bad" "computer.rip"                        "/rss.xml"]

# TODO: trim titles
["Jamie Brandon"     "scattered-thoughts.net"              "/feed.xml"]

# TODO: Ask him to update pubdate for articles older than Aug 25 2021
["Veit Heller"       "http://blog.veitheller.de"           "/feed.rss"]

# TODO: ask jordan to add timestamps to the 2822 dates
# ["jam1garner"        "jam1.re"                             "/rss"]

# TODO: parse dates from pages or ask for pubDate
# ["theorangeduck"     "http://theorangeduck.com"            "/feeds/pages"]

# TODO: debug missing feed root, maybe WP generators are bad?
# ["Organic Donut"     "organicdonut.com"                    "/feed"]

# mmmmm maybe
# ["Drew DeVault"      "drewdevault.com"                     "/blog/index.xml"]

# use https://github.com/Siriusmart/feedscraper for:
# TODO: blog.iximeow.net
# TODO: tmpout.sh

# remove once it stops updating/i'm finished reading
["toxic yuri" "amawashigroup.wordpress.com" "/feed"]

# ["λ the Ultimate"     "http://lambda-the-ultimate.org"      "/node/feed"]
])
