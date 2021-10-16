enum Emotion {
  calm,sad,surprised,fear,happy,confused,angry,disgusted,none
}

Emotion getEmotion (String type) {
  Emotion? emo;
  switch(type) {
    case "CALM" :
      emo = Emotion.calm;
      break;
    case "SAD" :
      emo = Emotion.sad;
      break;
    case "SURPRISED" :
      emo = Emotion.surprised;
      break;
    case "FEAR" :
      emo = Emotion.fear;
      break;
    case "HAPPY" :
      emo = Emotion.happy;
      break;
    case "CONFUSED" :
      emo = Emotion.confused;
      break;
    case "ANGRY" :
      emo = Emotion.angry;
      break;
    case "DISGUSTED" :
      emo = Emotion.disgusted;
      break;
    default :
      emo = Emotion.none;
  }

  return emo;
}


String getEmoDescript(String type) {
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
      text = "뭐가 그렇게 당신을 두렵게 하였나요? 제가 혼내줄게요  112에 신고해줄게요";
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
    case Emotion.none:
      text = "당신은 사람얼굴이 많나요? 사람 얼굴을 올려주세요";
      break;
  }

  return text;
}