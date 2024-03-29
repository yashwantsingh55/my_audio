import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:my_audio/player/content_model.dart';

import 'audio_player.dart';

class AudioPlayerController extends GetxController {
  late AudioPlayer player;
  RxInt currentAudioIndex = 0.obs;
  RxList<ContentModel> contentList = <ContentModel>[].obs;

  Rx<ProcessingState> playerState = ProcessingState.idle.obs;
  Rx<Duration> duration = Duration.zero.obs;
  Rx<Duration> position = Duration.zero.obs;



  AudioPlayerController() {
    player = AudioPlayerSingleton.instance.getAudioPlayer;

    player.playerStateStream.listen((event) {});

    player.positionStream.listen((event) {
      position.value = event;
    });

    insertDataInList();
  }



  insertDataInList()
  {
    List<Map<String,dynamic>> contentListData = contentMap['contents'] as List<Map<String,dynamic>>;


    for(final data in contentListData)
    {
      contentList.add(ContentModel.fromJson(data));
    }
  }
  updateCurrentAudioIndex(int index) {
    currentAudioIndex.value = index;
    player.setAudioSource(AudioSource.uri(
        Uri.parse(contentList[currentAudioIndex.value].audio.url),
        tag: MediaItem(
            id: currentAudioIndex.value.toString(),
            title: contentList[currentAudioIndex.value].contentType)));

    duration.value = player.duration ??Duration.zero;
  }

  increaseCurrentAudioIndex() {
    if (contentList.isNotEmpty &&
        currentAudioIndex.value < contentList.length - 1) {
      updateCurrentAudioIndex(currentAudioIndex.value + 1);
    }
  }

  decreaseCurrentMusicIndex() async {
    if (contentList.length > 1 && currentAudioIndex.value > 0) {
      updateCurrentAudioIndex(currentAudioIndex.value - 1);
    }
  }

  playAudio() async {
    if (contentList.isNotEmpty) {
      if (currentAudioIndex.value == 0) {
        updateCurrentAudioIndex(0);
      }
      await player.play();
    }
  }

  pauseAudio() async {
    await player.pause();
  }

  stopAudio() async {
    if (player.playerState.processingState == ProcessingState.ready) {
      await player.stop();
    }
  }
}



Map<String,dynamic> contentMap = {
  "contents": [
    {
      "contentId": "6d4a7f48-1fcc-4df7-9995-80393fc099fc",
      "contentName": "The Historic Prayer",
      "contentType": "Chapter",
      "images": {
        "icon": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-images/icon/Icon+Image+01.png",
        "landscape": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-images/landscape/Location+Details+_image+01.png",
        "portrait": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-images/portrait/Player+Page+Image+01.png"
      },
      "preview": [],
      "contentDescription": [
        {
          "small": "",
          "large": "This carving is of the historic prayer behind the BAPS Hindu Mandir in Abu Dhabi. \n\n On April 5, 1997, His Holiness Pramukh Swami Maharaj, along with a small group of swamis and devotees, visited the deserts of Sharjah. \n\n Naturally His Holiness had an instinctive habit of praying for others at any given time. \n\n And it was here, in the evening, in the heat of the desert, surrounded by a sandstorm, where HH Pramukh Swami Maharaj envisioned a place where people from all walks of life could come together to seek peace, experience love, and find harmony. \n\n He prayed for “a mandir in Abu Dhabi to bring countries, cultures, communities, and religions closer together.” \n\n 20 years later, His Highness Sheikh Mohammed Bin Zayed Al Nahyan generously gifted land for the mandir. And the selfless efforts of BAPS swamis, volunteers and thousands of well-wishers of diverse faiths, nationalities, and backgrounds came together to fulfill HH Pramukh Swami Maharaj’s vision, making this mandir a spiritual oasis for global harmony.",
          "languageCode": "en"
        }
      ],
      "video": [],
      "audio": {
        "url": "https://www.signalogic.com/melp/st/stn7.wav",
        "format": "wav",
        "script": []
      },
      "location": {"latitude": "", "longitude": ""},
      "parentId": "",
      "nextContentId": "8091703e-d8b0-4d1f-8d74-28d86f7b9351"
    },
    {
      "contentId": "8091703e-d8b0-4d1f-8d74-28d86f7b9351",
      "contentName": "Five Blind Men and the Elephant",
      "contentType": "Chapter",
      "images": {
        "icon": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-images/icon/Icon+Image+02.png",
        "landscape": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-images/landscape/Location+Details+_image+02.png",
        "portrait": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-images/portrait/Player+Page+Image+02.png"
      },
      "preview": [],
      "contentDescription": [
        {
          "small": "",
          "large": "Once, five blind men tried to see the elephant by feeling its body. \n\n The first, upon touching its trunk, proclaimed, The elephant is like a python, long and powerful! \n\n The second, feeling the elephant's ear, argued, No, the elephant is like a large fan!  \n\n The third, grasping the tail, shouted, Actually, it's more like a rope! \n\n The fourth, touching its belly, yelled, “No! The elephant is like a giant wall.” \n\n Lastly, the fifth, while holding its leg, concluded, The elephant is like a pillar!” \n\n They argued and bickered as all of them were partly right. They had felt a part of the elephant, but none of them had felt the whole. \n\n Similarly, in life, very often we are partly right about God, but only when we know God fully will we behold the Whole Truth, which is universal and eternal.",
          "languageCode": "en"
        }
      ],
      "video": [],
      "audio": {
        "url": "https://www.signalogic.com/melp/st/orig/nst.wav",
        "format": "wav",
        "script": []
      },
      "location": {"latitude": "", "longitude": ""},
      "parentId": "",
      "nextContentId": "7b8d6c77-eb68-4b86-ba70-2703f850c029"
    },
    {
      "contentId": "7b8d6c77-eb68-4b86-ba70-2703f850c029",
      "contentName": "Unity is Strength",
      "contentType": "Chapter",
      "images": {
        "icon": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-images/icon/Icon+Image+03.png",
        "landscape": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-images/landscape/Location+Details+_image+03.png",
        "portrait": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-images/portrait/Player+Page+Image+03.png"
      },
      "preview": [],
      "contentDescription": [
        {
          "small": "",
          "large": "Once, a flock of pigeons was trapped by a net. \n\n Panic spread amongst them as they frantically fluttered and flapped to free themselves. \n\n Taking charge, the lead pigeon calmed everyone and proposed a plan of unity. He encouraged every pigeon to flap together and fly together. With hearts and wings in sync, the pigeons flew away with the net and found their freedom. \n\n Teaching us that that divided, there is nothing we can do, united, there is nothing we cannot do.",
          "languageCode": "en"
        }
      ],
      "video": [],
      "audio": {
        "url": "https://www.signalogic.com/melp/st/stn5.wav",
        "format": "wav",
        "script": []
      },
      "location": {"latitude": "", "longitude": ""},
      "parentId": "",
      "nextContentId": "c21e8922-1be1-4799-8e20-c20e42e5aae7"
    },
    {
      "contentId": "c21e8922-1be1-4799-8e20-c20e42e5aae7",
      "contentName": "The Bundle of Arrows",
      "contentType": "Chapter",
      "images": {
        "icon": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-images/icon/Icon+Image+04.png",
        "landscape": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-images/landscape/Location+Details+_image+04.png",
        "portrait": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-images/portrait/Player+Page+Image+04.png"
      },
      "preview": [],
      "contentDescription": [
        {
          "small": "",
          "large": "One day, a king asked his soldiers to bring him a bundle of arrows. When they gathered, the king called for the strongest soldier and challenged him to break the bundle. He pushed, pulled, and strained with all his might, but not a single arrow snapped. \n\n Then, the king untied the bundle and gave a single arrow to his weakest soldier. He snapped it in an instant. \n\n The king smiled and said to his army, “When the arrows are together, they are unbreakable. But alone, they are weak and breakable.” \n\n Teaching us that alone we are weak, collectively and together, we are unbreakable, unshakeable.",
          "languageCode": "en"
        }
      ],
      "video": [],
      "audio": {
        "url": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-audio/the-bundle-of-arrows.wav",
        "format": "wav",
        "script": []
      },
      "location": {"latitude": "", "longitude": ""},
      "parentId": "",
      "nextContentId": "f1a05aad-c7bb-42d7-bdeb-66dbd618add9"
    },
    {
      "contentId": "f1a05aad-c7bb-42d7-bdeb-66dbd618add9",
      "contentName": "Our Parents Our World",
      "contentType": "Chapter",
      "images": {
        "icon": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-images/icon/Icon+Image+05.png",
        "landscape": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-images/landscape/Location+Details+_image+05.png",
        "portrait": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-images/portrait/Player+Page+Image+05.png"
      },
      "preview": [],
      "contentDescription": [
        {
          "small": "",
          "large": "High atop Mount Kailash, Bhagwan Shiv and Parvatiji were deep in thought about the future marriages of Kartikeya and Ganesha. To determine who would marry first, they planned for a test: the son who could circle the world fastest would be allowed to marry first. \n\n Kartikeya, swiftly mounted his ride, a peacock, and took to the skies, disappearing into the horizon. Poor Ganesha, whose ride was a mouse, felt at a disadvantage. \n\n Approaching his parents with a gentle step, Ganesha started walking around them. Sensing his parents' curiosity, Ganesha said, As a son, my world is my parents. Walking around you is like encircling the Earth itself. \n\n As Kartikeya returned, he witnessed the scene unfold. He realized, with a mix of inspiration and affection, the message his younger brother had taught him, that in life, respecting ones parents is the first step in winning the world.",
          "languageCode": "en"
        }
      ],
      "video": [],
      "audio": {
        "url": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-audio/our-parents-our-world.wav",
        "format": "wav",
        "script": []
      },
      "location": {"latitude": "", "longitude": ""},
      "parentId": "",
      "nextContentId": "c3d464ca-75de-407d-9552-db69acbbe2bf"
    },
    {
      "contentId": "c3d464ca-75de-407d-9552-db69acbbe2bf",
      "contentName": "The Unbreakable Brotherly Bond",
      "contentType": "Chapter",
      "images": {
        "icon": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-images/icon/Icon+Image+06.png",
        "landscape": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-images/landscape/Location+Details+_image+06.png",
        "portrait": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-images/portrait/Player+Page+Image+06.png"
      },
      "preview": [],
      "contentDescription": [
        {
          "small": "",
          "large": "Once, four brothers embarked upon a mission to appease the god of the seas, Ratnakar. They amicably divided their duties. One would meditate by the shore, while another bought supplies, the third cooked, and the fourth fetched water. \n\n Ratnakar decided to test their bond. He approached each brother individually, saying how the other brothers spoke negatively of him. Each brother had the same answer, “My brothers would never say such a thing!” \n\n Amazed by their unity and support for one another, Ratnakar revealed his true form and gave them the treasures of the ocean.. \n\n Teaching us that true unity can weather any storm, it not only wins the trust of one another, but also wins the love of the gods.",
          "languageCode": "en"
        }
      ],
      "video": [],
      "audio": {
        "url": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-audio/the-unbreakable-brotherly-bond+.wav",
        "format": "wav",
        "script": []
      },
      "location": {"latitude": "", "longitude": ""},
      "parentId": "",
      "nextContentId": "51bae435-cbeb-4c15-a50d-622d8891a97e"
    },
    {
      "contentId": "51bae435-cbeb-4c15-a50d-622d8891a97e",
      "contentName": "Duty Towards Parents",
      "contentType": "Chapter",
      "images": {
        "icon": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-images/icon/Icon+Image+07.png",
        "landscape": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-images/landscape/Location+Details+_image+07.png",
        "portrait": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-images/portrait/Player+Page+Image+07.png"
      },
      "preview": [],
      "contentDescription": [
        {
          "small": "",
          "large": "Once, a young boy named Shravan was devoted to serving his blind parents. \n\n One day, they declared their wish of going on a pilgrimage. It would take months, for India was a large country with a great many pilgrim places. And how would he guide two blind people, through valleys, jungles, cliffs and treacherous terrains? \n\n Despite the challenges and strong discouragement from others, his love for his parents found a way. He built huge scales and carried his parents in comfort. Every step he walked earned him divine blessings. \n\n Reminding us that our parents were there when we breathed our first; we should be there when they breathe their last!",
          "languageCode": "en"
        }
      ],
      "video": [],
      "audio": {
        "url": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-audio/duty-towards-parents.wav",
        "format": "wav",
        "script": []
      },
      "location": {"latitude": "", "longitude": ""},
      "parentId": "",
      "nextContentId": "9925586e-a8ef-4625-bc3a-b0623e451593"
    },
    {
      "contentId": "9925586e-a8ef-4625-bc3a-b0623e451593",
      "contentName": "God is Everywhere",
      "contentType": "Chapter",
      "images": {
        "icon": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-images/icon/Icon+Image+08.png",
        "landscape": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-images/landscape/Location+Details+_image+08.png",
        "portrait": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-images/portrait/Player+Page+Image+08.png"
      },
      "preview": [],
      "contentDescription": [
        {
          "small": "",
          "large": "Once, a wise guru gave his young disciples an apple and a special task. \n\n Eat the apple where no one can see you. \n\n Some hid in the trees and in the forests, in huts and caves, and came back feeling happy. Every disciple found a secret place and ate the apple. Only one came back with the apple in hand. Everyone laughed. Only the guru smiled. \n\n O Guru, you said we had to eat the apple where no one could see us. God sees me wherever I am, so how could I eat the apple? \n\n Teaching us that there are no secrets from God. He knows us, He sees us, and He is always with us.",
          "languageCode": "en"
        }
      ],
      "video": [],
      "audio": {
        "url": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-audio/god-is-everywhere.wav",
        "format": "wav",
        "script": []
      },
      "location": {"latitude": "", "longitude": ""},
      "parentId": "",
      "nextContentId": "f8043e77-dad7-4c44-8d31-61590cbb51fd"
    },
    {
      "contentId": "f8043e77-dad7-4c44-8d31-61590cbb51fd",
      "contentName": "Dattatreya and the 24 Gurus",
      "contentType": "Chapter",
      "images": {
        "icon": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-images/icon/Icon+Image+09.png",
        "landscape": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-images/landscape/Location+Details+_image+09.png",
        "portrait": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-images/portrait/Player+Page+Image+09.png"
      },
      "preview": [],
      "contentDescription": [
        {
          "small": "",
          "large": "In ancient India, a young Dattatreya, while in the forest, encountered King Yadu. Astonished by the child's sage-like divinity, the king asked him the secret of his happiness. \n\n Dattatreya revealed that he learned twenty-four lessons from the world around him. Each person, each creature, and each experience from which he learned he looked upon them as his gurus. \n\n The elements of nature taught him the strength of the earth, the freedom of the air, the purity of water, and the passion of fire. The celestial bodies taught him the clear vastness of self from the sky, the depth of peace from the ocean, the beauty in change from the moon, the selfless service of rising each day from the sun. \n\n The animal kingdom taught him the pain of attachment, the dangers of desire, and distraction, as well as the downfalls of greed, gluttony, and obsession. And lastly, the people taught him the joy of living in the moment, the value of dignity and duty, the power of concentration, and the pitfalls of possessiveness. \n\n Teaching us that the universe is a great teacher, offering lessons in every moment, if only one is willing to learn.",
          "languageCode": "en"
        }
      ],
      "video": [],
      "audio": {
        "url": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-audio/dattatreya-and-the-24-gurus.wav",
        "format": "wav",
        "script": []
      },
      "location": {"latitude": "", "longitude": ""},
      "parentId": "",
      "nextContentId": "802f38c7-74f3-473f-a1e2-04d2cb5f5f35"
    },
    {
      "contentId": "802f38c7-74f3-473f-a1e2-04d2cb5f5f35",
      "contentName": "Buddha’s Quest for Truth",
      "contentType": "Chapter",
      "images": {
        "icon": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-images/icon/Icon+Image+10.png",
        "landscape": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-images/landscape/Location+Details+_image+10.png",
        "portrait": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-images/portrait/Player+Page+Image+10.png"
      },
      "preview": [],
      "contentDescription": [
        {
          "small": "",
          "large": "Once, Prince Siddhartha who had never left his palace walls, ventured out with his charioteer. \n\n The prince saw things he had never seen before - a sick man, an old man, and a dead man. The charioteer would explain each to him \n He is sick, my prince, sickness visits all beings without warning. \n He is old, my lord. Age spares none. \n He is dead, my prince, the inevitable end for every living being. \n\n Lastly, the prince saw a figure in simple robes, and asked, \n Who is he, who walks so peacefully? \n\n He is a sage, my prince. He seeks answers to suffering, finding peace in detachment. He has left the world before the world leaves him, replied the charioteer. \n\n That night, Sidhartha found his answer. He rode to the forest's edge, where he exchanged his princely robes for the simple robes of a sage on his path to become Lord Buddha. \n\n Teaching us that the path to peace begins with self-realization.",
          "languageCode": "en"
        }
      ],
      "video": [],
      "audio": {
        "url": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-audio/buddha%E2%80%99squest-for-truth.wav",
        "format": "wav",
        "script": []
      },
      "location": {"latitude": "", "longitude": ""},
      "parentId": "",
      "nextContentId": "65e25cf3-0432-44da-aaee-e3d7e9d8763a"
    },
    {
      "contentId": "65e25cf3-0432-44da-aaee-e3d7e9d8763a",
      "contentName": "The Selfless Sacrifice of King Rantideva",
      "contentType": "Chapter",
      "images": {
        "icon": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-images/icon/Icon+Image+11.png",
        "landscape": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-images/landscape/Location+Details+_image+11.png",
        "portrait": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-images/portrait/Player+Page+Image+11.png"
      },
      "preview": [],
      "contentDescription": [
        {
          "small": "",
          "large": "Once, there lived a king named Rantideva. He served others without a second thought, and gave away all his wealth, until he became a beggar. For 48 days, he endured without food or water. \n\n On the forty-ninth morning, he received food. As he was about to eat, a sage appeared at his door. Without hesitation, he offered him the meal. \n\n Then, guest after guest arrived, and each time Rantideva gave away what little he had left, until not even water remained. \n\n As he faced death from thirst, the divine Trimurti revealed themselves, having taken the guise of his guests to test the depth of Rantideva's selfless sacrifice they liberated him. \n\n King Rantideva's story is a lesson of selfless sacrifice, teaching us that true wealth, liberation, is given to those who give.",
          "languageCode": "en"
        }
      ],
      "video": [],
      "audio": {
        "url": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-audio/the-selfless-service-of-king-rantideva.wav",
        "format": "wav",
        "script": []
      },
      "location": {"latitude": "", "longitude": ""},
      "parentId": "",
      "nextContentId": "bb6a2161-5705-4f60-adc6-e8eca5af1398"
    },
    {
      "contentId": "bb6a2161-5705-4f60-adc6-e8eca5af1398",
      "contentName": "Nachiketa and the God of Death",
      "contentType": "Chapter",
      "images": {
        "icon": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-images/icon/Icon+Image+12.png",
        "landscape": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-images/landscape/Location+Details+_image+12.png",
        "portrait": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-images/portrait/Player+Page+Image+12.png"
      },
      "preview": [],
      "contentDescription": [
        {
          "small": "",
          "large": "Once, a young Nachiketa watched his father donate weak and withered cows. He reminded his father that in charity one must give one’s best, not the weak and the worst. Angered, his father shouted, “You are my best, so I will gift you to Death himself!”  \n\n Nachiketa journeyed to the home of Yama, the god of death, where he waited three days without food or water. Upon Yama's return, he granted Nachiketa three wishes as a reward for his patience. \n\n He first asked for his father: his peace and his love. Second, he asked for society: the knowledge of elevating all. And third, he asked for the secrets of realizing the Soul and defeating Death himself. Yama tried hard to tempt and distract Nachiketa who remained firm and focused. Finally, impressed by the spiritual maturity and resolve of such a young boy, he granted these three wishes. \n\n Teaching us if your aim and resolve are unshakeable, then age is no bar for enlightenment.",
          "languageCode": "en"
        }
      ],
      "video": [],
      "audio": {
        "url": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-audio/nachiketa-and-the-god-of-death.wav",
        "format": "wav",
        "script": []
      },
      "location": {"latitude": "", "longitude": ""},
      "parentId": "",
      "nextContentId": "55b46587-199a-4648-9a75-87f90708cfe0"
    },
    {
      "contentId": "55b46587-199a-4648-9a75-87f90708cfe0",
      "contentName": "The Tortoise and Hare",
      "contentType": "Chapter",
      "images": {
        "icon": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-images/icon/Icon+Image+13.png",
        "landscape": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-images/landscape/Location+Details+_image+13.png",
        "portrait": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-images/portrait/Player+Page+Image+13.png"
      },
      "preview": [],
      "contentDescription": [
        {
          "small": "",
          "large": "Once upon a time, there lived a hare who was fast and famous, but also arrogant and boastful. He always made fun of the tortoise, who was the slowest animal he knew. Proudly, he challenged the tortoise to a race. Fearfully, the tortoise accepted knowing, full well he would lose. \n\n The race began. The hare shot forward, leaving the tortoise way behind. Super confident of his victory, the hare decided to sleep and rest. He thought the tortoise would never catch up, but he didn’t know that the tortoise would never give up. \n\n As the sun began to set, the hare woke up with a start. How long had he been asleep? He looked to find the tortoise nearing the finish line. Panicking, he sprinted with all his might, but it was too late. The tortoise crossed the line, greeted by the cheers of the forest animals. \n\n Teaching us that in life, slow and steady wins the race; \n Fast and foolhardy comes second place.",
          "languageCode": "en"
        }
      ],
      "video": [],
      "audio": {
        "url": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-audio/the-tortoise-and-hare.wav",
        "format": "wav",
        "script": []
      },
      "location": {"latitude": "", "longitude": ""},
      "parentId": "",
      "nextContentId": "a6748af1-4c91-4fdd-9c65-f4a9eb16f81a"
    },
    {
      "contentId": "a6748af1-4c91-4fdd-9c65-f4a9eb16f81a",
      "contentName": "Victory over Death",
      "contentType": "Chapter",
      "images": {
        "icon": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-images/icon/Icon+Image+14.png",
        "landscape": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-images/landscape/Location+Details+_image+14.png",
        "portrait": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-images/portrait/Player+Page+Image+14.png"
      },
      "preview": [],
      "contentDescription": [
        {
          "small": "",
          "large": "In the kingdom of Hastinapur, each day various pilgrims and sages visited. As per tradition, King Yudhistir would gift all who walked into the courts. One evening, just after sunset, a humble sage entered the grand halls. \n\n The King gently explained that the sun has set and he must wait until tomorrow to bestow any gift. Overhearing this interaction, Bhim began to beat the kingdom drum with all his might. \n\n O Yudhistir! Today you have defeated the greatest of all foes - death itself. By telling our guest to return tomorrow, you have claimed a victory over death! \n\n Yudhisthir, understanding the meaning behind his brother’s words, immediately sought out the sage and gifted him. \n\n He realized that no one’s future is certain, so we must value today more than yesterday and even tomorrow. So strive to do as much good as we can, to as many people as we can, for as long as we can.",
          "languageCode": "en"
        }
      ],
      "video": [],
      "audio": {
        "url": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-audio/victory-over-death.wav",
        "format": "wav",
        "script": []
      },
      "location": {"latitude": "", "longitude": ""},
      "parentId": "",
      "nextContentId": "a27a08bd-a871-4cb1-ae19-3c53aca60d4e"
    },
    {
      "contentId": "a27a08bd-a871-4cb1-ae19-3c53aca60d4e",
      "contentName": "The Lion Within",
      "contentType": "Chapter",
      "images": {
        "icon": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-images/icon/Icon+Image+15.png",
        "landscape": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-images/landscape/Location+Details+_image+15.png",
        "portrait": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-images/portrait/Player+Page+Image+15.png"
      },
      "preview": [],
      "contentDescription": [
        {
          "small": "",
          "large": "Once, a lion cub lost its way and joined a herd of goats. This cub, named Lindiyo, grew up thinking he was nothing more than another frail goat. \n\n One day, a mighty lion's roar echoed through the herd. All the goats ran and so did Lindiyo. The lion, puzzled at the sight of a lion amongst goats, captured him. Trembling with fear, Lindiyo pleaded for his life. \n\n You fool! You're a lion like me, why do you tremble like a goat? \n Saying this, he dragged a terrified Lindiyo to a pool of water. \n\n There, Lindiyo saw himself in the water. Not a goat, but a lion staring back at him.  \n\n Lindiyo felt strong and brave. He no longer ran like a goat, but roared like a lion. \n\n Teaching us that only when we realize who we really are, the lion within, will we be able to truly transform ourselves.",
          "languageCode": "en"
        }
      ],
      "video": [],
      "audio": {
        "url": "https://dev-baps.s3.ap-south-1.amazonaws.com/content/indian-value-tales/sample-audio/the-lion-within.wav",
        "format": "wav",
        "script": []
      },
      "location": {"latitude": "", "longitude": ""},
      "parentId": "",
      "nextContentId": ""
    }
  ]
};