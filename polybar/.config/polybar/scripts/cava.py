#!/usr/bin/env python3

import argparse
import os
import signal
import subprocess
import sys
import tempfile

# Sous-processus qui convertit la sortie de cava en caractères pour Polybar
if len(sys.argv) > 1 and sys.argv[1] == '--subproc':
    ramp_list = [' ', '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█']
    ramp_list.extend(
        f'%{{F#{color.strip(" #")}}}█%{{F-}}'
        for color in sys.argv[2].split(',')
        if color
    )

    while True:
        try:
            cava_input = input().strip().split()
        except EOFError:
            break

        cava_input = [int(i) for i in cava_input]
        output = ''

        for bar in cava_input:
            if bar < len(ramp_list):
                output += ramp_list[bar]
            else:
                output += ramp_list[-1]

        print(output, flush=True)

    sys.exit(0)


# Arguments
parser = argparse.ArgumentParser()
parser.add_argument(
    '-f', '--framerate',
    type=int,
    default=60,
    help='Framerate de CAVA (défaut : 60)'
)

parser.add_argument(
    '-b', '--bars',
    type=int,
    default=8,
    help='Nombre de barres (défaut : 8)'
)

parser.add_argument(
    '-e', '--extra_colors',
    default='fdd,fcc,fbb,faa',
    help='Couleurs des niveaux élevés'
)

parser.add_argument(
    '-c', '--channels',
    choices=['stereo', 'left', 'right', 'average'],
    default='stereo',
    help='Canal audio'
)

parser.add_argument(
    '-s', '--source',
    default=None,
    help='Source PipeWire/PulseAudio (ex: alsa_input.xxx)'
)

opts = parser.parse_args()

# Configuration des canaux
conf_channels = ''
if opts.channels != 'stereo':
    conf_channels = (
        'channels=mono\n'
        f'mono_option={opts.channels}\n'
    )

# Configuration de l'entrée
conf_input = (
    '[input]\n'
    'method=pipewire\n'
)

if opts.source:
    conf_input += f'source={opts.source}\n'

conf_ascii_max_range = 12 + len([
    i for i in opts.extra_colors.split(',')
    if i
])

# Création du fichier de configuration temporaire
fd, cava_conf = tempfile.mkstemp(prefix='polybar-cava-conf.')
os.close(fd)

with open(cava_conf, 'w') as f:
    f.write(
        '[general]\n'
        f'framerate={opts.framerate}\n'
        f'bars={opts.bars}\n'
        '\n'
        + conf_input +
        '\n'
        '[output]\n'
        'method=raw\n'
        'data_format=ascii\n'
        f'ascii_max_range={conf_ascii_max_range}\n'
        'bar_delimiter=32\n'
        + conf_channels
    )

# Lancement de CAVA
cava_proc = subprocess.Popen(
    ['cava', '-p', cava_conf],
    stdout=subprocess.PIPE,
    text=True
)

# Lancement du convertisseur
self_proc = subprocess.Popen(
    [
        'python3',
        __file__,
        '--subproc',
        opts.extra_colors
    ],
    stdin=cava_proc.stdout,
    text=True
)


def cleanup(sig, frame):
    try:
        os.remove(cava_conf)
    except FileNotFoundError:
        pass

    cava_proc.kill()
    self_proc.kill()
    sys.exit(0)


signal.signal(signal.SIGTERM, cleanup)
signal.signal(signal.SIGINT, cleanup)

self_proc.wait()

cleanup(None, None)