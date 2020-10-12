# PitchturePerfect
Processing Sketch to play music based on colors of pixel with SoundFile

Firstly, I assign a color for each chord. Next, identify the color of each individual pixel on the image and compare to each chord color using dist(). The chord color closest to the pixel color will have 1 added to its total count. The total count of each chord will be used to decide the music that will be generated.

I drew inspiration from Musical metacreation in MuseBot ensemble . It is an idea that was build upon “algorithmic composition, generative music, machine musicianship and live algorithms”. The definition of computational creativity is to simulate behaviors that would be deemed creative by human observation. However, as mentioned in the studies cited, some restrictions have to still be in place for the music generated to sound pleasant. I have decided to impose a simple chord progression in this case as there are limitations in my knowledge in music theory.

2 for-loops were used to scan through the image, compared with color of each chord and picking the chord color with the shortest distance to the pixel color. This is similar to the analyze done be the DARCI system but in a less complex manner. 

In the method Play(), the system first determine which scale should the chord progression be in (G major or C major) by comparing which has a higher count. Next, based on the major, it will determine the last note according to what was suggested in the video for writing chord progression. Results are based completely on the image loaded without any human intervention and is based solely on the algorithm.

# Instructions
Copy the code into processing.
Run the Sketch.
Click on Select_file and select any image you desired.
Press Play
