import 'package:tomorrow_diary/utils/utils.dart';

enum Emotion {
  calm,sad,surprised,fear,happy,confused,angry,disgusted,positive,negative,neutral,mixed,none
}



Emotion getEmotion (String type) {
  Emotion? emo;
  switch(type) {
    case CALM :
      emo = Emotion.calm;
      break;
    case SAD :
      emo = Emotion.sad;
      break;
    case SURPRISED :
      emo = Emotion.surprised;
      break;
    case FEAR :
      emo = Emotion.fear;
      break;
    case HAPPY :
      emo = Emotion.happy;
      break;
    case CONFUSED :
      emo = Emotion.confused;
      break;
    case ANGRY :
      emo = Emotion.angry;
      break;
    case DISGUSTED :
      emo = Emotion.disgusted;
      break;
    case POSITIVE :
      emo = Emotion.positive;
      break;
    case NEGATIVE : 
      emo = Emotion.negative;
      break;
    case MIXED :
      emo = Emotion.mixed;
      break;
    case NEUTRAL:
      emo = Emotion.neutral;
      break;
    default :
      emo = Emotion.none;
  }

  return emo;
}


String getEmoDescript(String? type) {
  if(type == '' || type == null) {
    return "오늘의 사진과 오늘의 일기를 AI를 통해 표정을 분석하여 오늘의 기분을 나타내줍니다. 사진이나 오늘의 일기를 작성해주세요";
  }
  Emotion emo = getEmotion(type);
  String text= "";
  switch(emo) {
    
    case Emotion.calm:
      text = "오늘은 침착해보이시네요.. 항상 그렇게 침착하게 사진찍나요? 내일은 다양한표정으로 찍어보세요!!";
      break;
    case Emotion.sad:
      text = "연인이랑 헤어지셨나요? 너무 슬퍼보여요.. 기운내요 다른 좋은일이 있을거랍니다.";
      break;
    case Emotion.surprised:
      text = "많이 놀라셨나봐요. 간은 떨어지지는 아니하였죠?"; 
      break;
    case Emotion.fear:
      text = "뭐가 그렇게 당신을 두렵게 하였나요? 제가 혼내줄게요!";
      break;
    case Emotion.happy:
      text = "너무 행복해보여요!! 내일도 오늘같이 행복했으면 좋겠어요!!";
      break;
    case Emotion.confused:
      text = "고민이 많아보여요ㅜㅜ.. 너무 고민하지말고 차근차근 하나씩 시작해보는 것은 어떨까요?";
      break;
    case Emotion.angry:
      text = "화내지 마세요.. 무서워요.. 화는 당신을 병들게 한답니다.";
      break;
    case Emotion.disgusted:
      text = "당신의 얼굴은 역겹네요.. 다시 찍으세요!!";
      break;
    case Emotion.positive:
      text = "당신은 오늘 정말 긍정적이시군요. 앞으로도 오늘 같은 일만 있었으면 좋겠습니다!!";
      break;
    case Emotion.negative:
      text = "당신은 오늘 너무 부정적이세요. 내일부터는 좀 더 긍정적으로 생각해보면 어떨까요?";
      break;
    case Emotion.neutral:
      text = "오늘 기분은 참 So So 하시네요!! 그래도 기분이 안 좋지는 않아서 다행입니다!!";
      break;
    case Emotion.mixed:
      text= "많이 혼란스러운 것 같아요.. 무슨일이 있으신가요?? 너무 복잡하게 생각하지는 말았으면 해요";
      break;
    case Emotion.none:
      text = "당신은 사람얼굴이 많나요? 사람 얼굴을 올려주세요";
      break;
  }

  return text;
}