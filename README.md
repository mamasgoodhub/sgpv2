Projekt starten:
0. LTS Godot runterladen unter https://godotengine.org/download/windows/ - Mindestens V4.X benötigt
1. Projekt über "master" Branch > Code > Download ZIP herunterladen
2. Godot starten, ZIP-Inhalt per Drag'n'Drop in das Projektübersichts-Fenster ziehen
3. Projekt starten
4. Spiel kann mit F5 gestartet werden

WICHTIGE INFO:
Das Spiel ist noch super buggy, ein extrem wichtiges Detail ist, das NPCs den Arbeitsorten in der Reihenfolge zugewiesen werden wie sie gebaut wurden.
Beispiel Baureihenfolge:
INFO: Eine Wohneinheit kann 2x NPCs behausen, ein Arbeitsort benötigt 2x NPCs, ein Arbeitsort benötigt X Energie
Wohneinheit>Nahrung>Energie>Wohneinheit>Holz>Nahrung

Die NPCs der ersten Wohneinheit werden dem Nahrungsgebäude zugewiesen, dieses kann aber nicht produzieren, da noch kein Energiegebäude steht. Hier landet der Spieler so lang
in einem Loop, bis das nächste Energiegebäude mit NPCs gefüllt wird und somit Energie produzieren kann. Bedeutet das Nahrungsgebäude steht vorerst still.
ES GIBT ALSO KEINE PRIORITÄT!!! Das hat in den Playtests extrem zur Verwirrung gesorgt, aber ein fix hätte bei dem Codedurcheinander zu lang gedauert, weshalb hier kurz darauf
hingewiesen wird :^)

--

Hotfix für V2
Es wurden einige Bugs entfernt:
- Wolken und der Graufilter haben nicht richtig funktioniert, sobald das co2 auf 0 gefallen ist, sind die Wolken nicht mehr verschwunden.
- Es gab ein paar Anzeigefehler bei den Ressourcen die gefixt wurden.
- Balancing wurde verbessert. Holzfarmen kosten nichts mehr, weil man nichts mehr bauen kann, sobald man kein Holz mehr zur Verfügung hat.
- Sobald man Ressourcen nicht mehr zur Verfügung hatte, konnte man in der nächsten Runde keine Gebäude mehr platzieren.

Neuerungen:
- Bäume verschwinden nun wenn zu viele Holzfarmen gebaut werden. Um das zu umgehen, müssen diese per Rechtsklick entfernt werden
- Gebäude abgesehen von Wohnhäusern, lassen sich jetzt per Rechtsklick auf das jeweilge Gebäude entfernen.