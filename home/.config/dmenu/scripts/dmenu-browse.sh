#!/usr/bin/env bash

# Source all the settings
. $HOME/.config/dmenu/settings

# Uses default browser else firefox
DMBROWSER="${BROWSER:-firefox}"
declare -a options=( "amazon - https://www.amazon.ca/s?k="
                     "archaur - https://aur.archlinux.org/packages/?O=0&K="
                     "archpkg - https://archlinux.org/packages/?sort=&q="
                     "archwiki - https://wiki.archlinux.org/index.php?search="
                     "arxiv - https://arxiv.org/search/?searchtype=all&source=header&query="
                     "bbcnews - https://www.bbc.co.uk/search?q="
                     "bing - https://www.bing.com/search?q="
                     "cliki - https://www.cliki.net/site/search?query="
                     "cnn - https://www.cnn.com/search?q="
                     "coinbase - https://www.coinbase.com/price?query="
                     "debianpkg - https://packages.debian.org/search?suite=default&section=all&arch=any&searchon=names&keywords="
                     "discogs - https://www.discogs.com/search/?&type=all&q="
                     "duckduckgo - https://duckduckgo.com/?q="
                     "ebay - https://www.ebay.ca/sch/i.html?&_nkw="
                     "github - https://github.com/search?q="
                     "gitlab - https://gitlab.com/search?search="
                     "google - https://www.google.ca/search?q="
                     "googleimages - https://www.google.ca/search?hl=en&tbm=isch&q="
                     "googlenews - https://news.google.ca/search?q="
                     "imdb - https://www.imdb.com/find?q="
                     "lbry - https://lbry.tv/$/search?q="
                     "odysee - https://odysee.com/$/search?q="
                     "reddit - https://www.reddit.com/search/?q="
                     "slashdot - https://slashdot.org/index2.pl?fhfilter="
                     "socialblade - https://socialblade.com/youtube/user/"
                     "sourceforge - https://sourceforge.net/directory/?q="
                     "stack - https://stackoverflow.com/search?q="
                     "startpage - https://www.startpage.com/do/dsearch?query="
                     "stockquote - https://finance.yahoo.com/quote/"
                     "thesaurus - https://www.thesaurus.com/misspelling?term="
                     "translate - https://translate.google.com/?sl=auto&tl=en&text="
                     "urban - https://www.urbandictionary.com/define.php?term="
                     "wayback - https://web.archive.org/web/*/"
                     "webster - https://www.merriam-webster.com/dictionary/"
                     "wikipedia - https://en.wikipedia.org/wiki/"
                     "wiktionary - https://en.wiktionary.org/wiki/"
                     "wolfram - https://www.wolframalpha.com/input/?i="
                     "youtube - https://www.youtube.com/results?search_query="
                     "quit" )

while [ -z "$engine" ]; do
  enginelist=$(printf '%s\n' "${options[@]}" | dmenu -h $DMENU_CUSTOM_HEIGHT -fn "$DMENU_CUSTOM_FONT" -nb "$DMENU_CUSTOM_NB" -nf "$DMENU_CUSTOM_NF" -sb "$DMENU_CUSTOM_SB" -sf "$DMENU_CUSTOM_SF" -s -n -l 20 -p 'Choose search engine:') || exit
  engineurl=$(echo "$enginelist" | awk '{print $NF}')
  engine=$(echo "$enginelist" | awk '{print $1}')
done

while [ -z "$query" ]; do
  if [[ "$engine" == "quit" ]]; then
    echo "Program terminated." && exit 0
  else
    query=$(echo "$engine" | dmenu -h $DMENU_CUSTOM_HEIGHT -fn "$DMENU_CUSTOM_FONT" -nb "$DMENU_CUSTOM_NB" -nf "$DMENU_CUSTOM_NF" -sb "$DMENU_CUSTOM_SB" -sf "$DMENU_CUSTOM_SF" -s -p 'Enter search query:') || exit
  fi
done

# Display search results in web browser
$DMBROWSER "${engineurl}${query}"
