/* =========== 시간 관련 번역 =========== */
function minutes() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "min";
  } else if($.cookie("langCode") == "ja"){
    text = "分";
  } else if($.cookie("langCode") == "zh"){
    text = "分钟";
  } else {
    text = "분";
  }
  return text;
}

function soon() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Recent";
  } else if($.cookie("langCode") == "ja"){
    text = "さっき";
  } else if($.cookie("langCode") == "zh"){
    text = "刚刚";
  } else {
    text = "방금";
  }
  return text;
}

function minuteAgo() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "min. ago";
  } else if($.cookie("langCode") == "ja"){
    text = "分前";
  } else if($.cookie("langCode") == "zh"){
    text = "分鐘前";
  } else {
    text = "분 전";
  }
  return text;
}

function hourAgo() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "hr. ago";
  } else if($.cookie("langCode") == "ja"){
    text = "時間前";
  } else if($.cookie("langCode") == "zh"){
    text = "小時前";
  } else {
    text = "시간 전";
  }
  return text;
}

function getYesterDay() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "yesterday";
  } else if($.cookie("langCode") == "ja"){
    text = "昨日";
  } else if($.cookie("langCode") == "zh"){
    text = "昨天";
  } else {
    text = "어제";
  }
  return text;
}

function dayBeforeYesterday() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "2 days ago";
  } else if($.cookie("langCode") == "ja"){
    text = "一昨日";
  } else if($.cookie("langCode") == "zh"){
    text = "前天";
  } else {
    text = "그저께";
  }
  return text;
}

function dayAgo() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "days ago";
  } else if($.cookie("langCode") == "ja"){
    text = "日前";
  } else if($.cookie("langCode") == "zh"){
    text = "分钟前";
  } else {
    text = "일 전";
  }
  return text;
}

function month(mon) {
  var text = "";
  if($.cookie("langCode") == "en"){
    switch (mon) {
      case '1'  : text = "Jan "; break;
      case '2'  : text = "Feb "; break;
      case '3'  : text = "Mar "; break;
      case '4'  : text = "Apr "; break;
      case '5'  : text = "May "; break;
      case '6'  : text = "Jun "; break;
      case '7'  : text = "Jul "; break;
      case '8'  : text = "Aug "; break;
      case '9'  : text = "Sep "; break;
      case '10'  : text = "Oct "; break;
      case '11'  : text = "Nov "; break;
      case '12'  : text = "Dec "; break;
      default:break;
    }
  } else if($.cookie("langCode") == "ja"){
    text = mon+"月 ";
  } else if($.cookie("langCode") == "zh"){
    text = mon+"月 ";
  } else {
    text = mon+"월 ";
  }
  return text;
}

function monthDay() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "";
  } else if($.cookie("langCode") == "ja"){
    text = "日";
  } else if($.cookie("langCode") == "zh"){
    text = "日";
  } else {
    text = "일";
  }
  return text;
}

/* =========== 부탁 관련 번역 =========== */
// task sort
function taskSortRecent() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Recent↓";
  } else if($.cookie("langCode") == "ja"){
    text = "登録日↓";
  } else if($.cookie("langCode") == "zh"){
    text = "期限↓";
  } else {
    text = "최신↓";
  }
  return text;
}

function taskSortDueDate() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Due date↓";
  } else if($.cookie("langCode") == "ja"){
    text = "期限↓";
  } else if($.cookie("langCode") == "zh"){
    text = "期限↓";
  } else {
    text = "기한↓";
  }
  return text;
}

function taskSortName() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Name↓";
  } else if($.cookie("langCode") == "ja"){
    text = "名前↓";
  } else if($.cookie("langCode") == "zh"){
    text = "执行者名字↓";
  } else {
    text = "수행자 이름↓";
  }
  return text;
}
// task type
function taskTypeAllTask() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "All";
  } else if($.cookie("langCode") == "ja"){
    text = "全て";
  } else if($.cookie("langCode") == "zh"){
    text = "全部";
  } else {
    text = "전체 부탁";
  }
  return text;
}

function taskTypeRequestTask() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Task Sent";
  } else if($.cookie("langCode") == "ja"){
    text = "お願いした仕事";
  } else if($.cookie("langCode") == "zh"){
    text = "发送的请求";
  } else {
    text = "내가 한 부탁";
  }
  return text;
}

function taskTypeRequestForMe() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Task Received";
  } else if($.cookie("langCode") == "ja"){
    text = "お願いされた仕事";
  } else if($.cookie("langCode") == "zh"){
    text = "收到的请求";
  } else {
    text = "내가 받은 부탁";
  }
  return text;
}

function taskTypeRequestJustSee() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Task to see";
  } else if($.cookie("langCode") == "ja"){
    text = "参照した仕事";
  } else if($.cookie("langCode") == "zh"){
    text = "参照的请求";
  } else {
    text = "참조한 부탁";
  }
  return text;
}

/* =========== 프로필 관련 번역 =========== */
function taskWithMe() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "My tasks";
  } else if($.cookie("langCode") == "ja"){
    text = "自分の仕事を見る";
  } else if($.cookie("langCode") == "zh"){
    text = "查看我的请求";
  } else {
    text = "내 부탁 보기";
  }
  return text;
}

/* =========== 채팅 리스트 관련 번역 =========== */
function chatRoomNameChanged(chatRoomName) {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "The chat room name was changed to '" +chatRoomName+ "'";
  } else if($.cookie("langCode") == "ja"){
    text = "チャットルーム名が '" +chatRoomName+ "' に変更されました。";
  } else if($.cookie("langCode") == "zh"){
    text = "聊天室的名称变更为 '"+chatRoomName+"'";
  } else {
    text = "채팅방 이름이 '" +chatRoomName+ "' (으)로 변경되었습니다.";
  }
  return text;
}

function chatRoomNameRemove() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "It has removed the chat room name.";
  } else if($.cookie("langCode") == "ja"){
    text = "チャットルームの名前を削除しました。";
  } else if($.cookie("langCode") == "zh"){
    text = "它已经删除了聊天室的名称。";
  } else {
    text = "채팅방 이름을 삭제하였습니다.";
  }
  return text;
}

function chattingJoined() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Joined";
  } else if($.cookie("langCode") == "ja"){
    text = "さんが入室しました";
  } else if($.cookie("langCode") == "zh"){
    text = "进入对话窗";
  } else {
    text = "님이 입장하셨습니다";
  }
  return text;
}

function chattingLeaved() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Left";
  } else if($.cookie("langCode") == "ja"){
    text = "さんがチャットルームを退出しました";
  } else if($.cookie("langCode") == "zh"){
    text = "离开对话窗";
  } else {
    text = "님이 채팅방을 나갔습니다";
  }
  return text;
}

function chattingCreated() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "New Task";
  } else if($.cookie("langCode") == "ja"){
    text = "新しいタスク";
  } else if($.cookie("langCode") == "zh"){
    text = "新任务";
  } else {
    text = "새로운 부탁";
  }
  return text;
}

function chattingDeleted() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Task Deleted";
  } else if($.cookie("langCode") == "ja"){
    text = "タスクの削除済み";
  } else if($.cookie("langCode") == "zh"){
    text = "任务已删除";
  } else {
    text = "삭제된 부탁";
  }
  return text;
}

function chattingUpdated() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Task Edited";
  } else if($.cookie("langCode") == "ja"){
    text = "タスクの編集";
  } else if($.cookie("langCode") == "zh"){
    text = "编辑任务";
  } else {
    text = "수정된 부탁";
  }
  return text;
}

function chattingDoing() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "In Progress";
  } else if($.cookie("langCode") == "ja"){
    text = "実行中";
  } else if($.cookie("langCode") == "zh"){
    text = "操作中";
  } else {
    text = "하는중";
  }
  return text;
}

function chattingDone() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Compeleted";
  } else if($.cookie("langCode") == "ja"){
    text = "完了";
  } else if($.cookie("langCode") == "zh"){
    text = "已完成";
  } else {
    text = "다했어요";
  }
  return text;
}

function chattingConfirm() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Approved";
  } else if($.cookie("langCode") == "ja"){
    text = "確認";
  } else if($.cookie("langCode") == "zh"){
    text = "确认";
  } else {
    text = "확인";
  }
  return text;
}

function chattingNotStarted() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "New";
  } else if($.cookie("langCode") == "ja"){
    text = "新規";
  } else if($.cookie("langCode") == "zh"){
    text = "新";
  } else {
    text = "새로운";
  }
  return text;
}

function chattingStatusChanged(taskTitle) {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Status changed in" +taskTitle;
  } else if($.cookie("langCode") == "ja"){
    text = taskTitle + " の状態が変更されました";
  } else if($.cookie("langCode") == "zh"){
    text = taskTitle + " 的状态已变更";
  } else {
    text = taskTitle + " 의 상태변경";
  }
  return text;
}

function chattingPleaseCheck(status) {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Please Check " + status;
  } else if($.cookie("langCode") == "ja"){
    text = " をご確認ください";
  } else if($.cookie("langCode") == "zh"){
    text = "请检查";
  } else {
    text = " 부탁의 상태를 확인해주세요";
  }
  return text;
}

/* =========== 부탁 상세 페이지 관련 번역 =========== */
function translateChatting() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Chats";
  } else if($.cookie("langCode") == "ja"){
    text = "チャット";
  } else if($.cookie("langCode") == "zh"){
    text = "对话";
  } else {
    text = "채팅";
  }
  return text;
}

function translateReject() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Unsatisfactory!";
  } else if($.cookie("langCode") == "ja"){
    text = "リジェクト!";
  } else if($.cookie("langCode") == "zh"){
    text = "重新做!";
  } else {
    text = "좀 부족해!";
  }
  return text;
}

function translateEdit() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Edit";
  } else if($.cookie("langCode") == "ja"){
    text = "修正";
  } else if($.cookie("langCode") == "zh"){
    text = "修改";
  } else {
    text = "수정";
  }
  return text;
}

function translateDelete() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Delete";
  } else if($.cookie("langCode") == "ja"){
    text = "削除";
  } else if($.cookie("langCode") == "zh"){
    text = "删除";
  } else {
    text = "삭제";
  }
  return text;
}

function translateConfirm() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Approved";
  } else if($.cookie("langCode") == "ja"){
    text = "確認";
  } else if($.cookie("langCode") == "zh"){
    text = "确认";
  } else {
    text = "확인";
  }
  return text;
}

function translateConfirm() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Approved";
  } else if($.cookie("langCode") == "ja"){
    text = "確認";
  } else if($.cookie("langCode") == "zh"){
    text = "确认";
  } else {
    text = "확인";
  }
  return text;
}

function translateDoing() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "In Progress";
  } else if($.cookie("langCode") == "ja"){
    text = "実行中";
  } else if($.cookie("langCode") == "zh"){
    text = "操作中";
  } else {
    text = "하는중";
  }
  return text;
}

function translateDone() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Compeleted";
  } else if($.cookie("langCode") == "ja"){
    text = "完了";
  } else if($.cookie("langCode") == "zh"){
    text = "已完成";
  } else {
    text = "다했어요";
  }
  return text;
}

function translateDeleteConfirm() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Are you sure you want to delete?";
  } else if($.cookie("langCode") == "ja"){
    text = "本当に削除してよろしいですか？";
  } else if($.cookie("langCode") == "zh"){
    text = "是否真的删除?";
  } else {
    text = "정말 삭제하실건가요?";
  }
  return text;
}

function translateTaskCreatorConfirm() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Are you going to manage with the task?";
  } else if($.cookie("langCode") == "ja"){
    text = "あなたは、タスク要求で管理するつもりですか？";
  } else if($.cookie("langCode") == "zh"){
    text = "你要与任务的要求来管理？";
  } else {
    text = "부탁을 관리하실건가요?";
  }
  return text;
}

function translateTaskAssigneeConfirm() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Are you going to proceed with the task?";
  } else if($.cookie("langCode") == "ja"){
    text = "お願いを実行しますか？";
  } else if($.cookie("langCode") == "zh"){
    text = "是否执行请求?";
  } else {
    text = "부탁을 수행하실건가요?";
  }
  return text;
}

function translateTaskAssigneeMe() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "I will do it!";
  } else if($.cookie("langCode") == "ja"){
    text = "自分の仕事!";
  } else if($.cookie("langCode") == "zh"){
    text = "我来做!";
  } else {
    text = "내가 할께요!";
  }
  return text;
}

/* =========== 부탁 수정 페이지 관련 번역 =========== */
function translateTask() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Task";
  } else if($.cookie("langCode") == "ja"){
    text = "仕事";
  } else if($.cookie("langCode") == "zh"){
    text = "请求";
  } else {
    text = "부탁";
  }
  return text;
}

function translateDueDate() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Due Date";
  } else if($.cookie("langCode") == "ja"){
    text = "期限";
  } else if($.cookie("langCode") == "zh"){
    text = "期限";
  } else {
    text = "기한";
  }
  return text;
}

function translateTaskContent() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Task content";
  } else if($.cookie("langCode") == "ja"){
    text = "タスクの内容";
  } else if($.cookie("langCode") == "zh"){
    text = "任务内容";
  } else {
    text = "부탁내용";
  }
  return text;
}

function translatePerformer() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Performer";
  } else if($.cookie("langCode") == "ja"){
    text = "アテンダント";
  } else if($.cookie("langCode") == "zh"){
    text = "人们工作";
  } else {
    text = "수행자";
  }
  return text;
}

function deleteNickname() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Are you sure you want to delete the nickname of a friend?";
  } else if($.cookie("langCode") == "ja"){
    text = "あなたは友人のニックネームを削除してもよろしいですか？";
  } else if($.cookie("langCode") == "zh"){
    text = "您确定要删除朋友的昵称吗？";
  } else {
    text = "닉네임을 삭제하시겠습니까?";
  }
  return text;
}

function enterNickname() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Enter nickname";
  } else if($.cookie("langCode") == "ja"){
    text = "ニックネームを入力してください";
  } else if($.cookie("langCode") == "zh"){
    text = "输入昵称";
  } else {
    text = "닉네임을 입력 해 주세요";
  }
  return text;
}

function enterStatusMessage() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Enter status message";
  } else if($.cookie("langCode") == "ja"){
    text = "ステータスメッセージを入力してください";
  } else if($.cookie("langCode") == "zh"){
    text = "输入状态消息";
  } else {
    text = "상태 메시지를 입력 해 주세요";
  }
  return text;
}

function deleteStatusMessage() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Are you sure you want to delete the status message?";
  } else if($.cookie("langCode") == "ja"){
    text = "ステータスメッセージを削除しますか？";
  } else if($.cookie("langCode") == "zh"){
    text = "删除状态消息？";
  } else {
    text = "상태 메세지를 삭제하시겠습니까?";
  }
  return text;
}

function chatRoomMoreDetailsClick() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "More details click ";
  } else if($.cookie("langCode") == "ja"){
    text = "詳細については、クリックしてください ";
  } else if($.cookie("langCode") == "zh"){
    text = "更多细节点击 ";
  } else {
    text = "보다 자세한 설명은 ";
  }
  return text;
}

function chatRoomHere() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "here";
  } else if($.cookie("langCode") == "ja"){
    text = "ここに";
  } else if($.cookie("langCode") == "zh"){
    text = "这里";
  } else {
    text = "여기";
  }
  return text;
}

function chatRoomClick() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "";
  } else if($.cookie("langCode") == "ja"){
    text = "";
  } else if($.cookie("langCode") == "zh"){
    text = "";
  } else {
    text = " 를 클릭 해 주세요";
  }
  return text;
}

function addressBook(langCode) {
  var text = "";
  if(langCode == "en"){
    text = "Address";
  } else if(langCode == "ja"){
    text = "住所録";
  } else if(langCode == "zh"){
    text = "地址簿";
  } else {
    text = "주소록";
  }
  return text;
}

function TaskChangedBody() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Contents,";
  } else if($.cookie("langCode") == "ja"){
    text = "内容,";
  } else if($.cookie("langCode") == "zh"){
    text = "内容,";
  } else {
    text = "내용,";
  }
  return text;
}

function TaskChangedDueDate() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Due Date,";
  } else if($.cookie("langCode") == "ja"){
    text = "期限,";
  } else if($.cookie("langCode") == "zh"){
    text = "期限,";
  } else {
    text = "기한,";
  }
  return text;
}

function TaskChangedAssignee() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Assignee,";
  } else if($.cookie("langCode") == "ja"){
    text = "お願いする相手,";
  } else if($.cookie("langCode") == "zh"){
    text = "选择请求好友,";
  } else {
    text = "부탁 받는 사람,";
  }
  return text;
}

function TaskChangedEdited() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = " Edited";
  } else if($.cookie("langCode") == "ja"){
    text = " 修正された";
  } else if($.cookie("langCode") == "zh"){
    text = " 编辑";
  } else {
    text = " 수정됨";
  }
  return text;
}

function AllFriends(){
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "All friends";
  } else if($.cookie("langCode") == "ja"){
    text = "友達みんな";
  } else if($.cookie("langCode") == "zh"){
    text = "所有朋友";
  } else {
    text = "모든 친구";
  }
  return text;
}

function friendsSharingTask(){
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Friends sharing task";
  } else if($.cookie("langCode") == "ja"){
    text = "お願いがある友人";
  } else if($.cookie("langCode") == "zh"){
    text = "与朋友要求";
  } else {
    text = "부탁이 있는 친구";
  }
  return text;
}

function friendsSharingTaskBeforeConfirmed(){
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Friend with task before confirmed";
  } else if($.cookie("langCode") == "ja"){
    text = "確認する前にタスクを持つ友人";
  } else if($.cookie("langCode") == "zh"){
    text = "朋友与任务之前确认";
  } else {
    text = "확인 전 부탁이 있는 친구";
  }
  return text;
}

function isStopMessage(){
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Disable ID. \nFor more information, please contact us at tellme.deltapds@gmail.com";
  } else if($.cookie("langCode") == "ja"){
    text = "使用停止IDです。 \n詳細については、tellme.deltapds@gmail.comを介してお問い合わせください。";
  } else if($.cookie("langCode") == "zh"){
    text = "停止使用ID。 \n欲了解更多信息，请通过tellme.deltapds@gmail.com与我们联系。";
  } else {
    text = "사용정지 아이디입니다. \n자세한 사항은 tellme.deltapds@gmail.com 을 통해 문의 해 주세요.";
  }
  return text;
}

function statusMessageLimit(){
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "It can be up to 30characters.";
  } else if($.cookie("langCode") == "ja"){
    text = "最大30文字まで入力できます。";
  } else if($.cookie("langCode") == "zh"){
    text = "最多可包含30个字符。";
  } else {
    text = "30글자 까지 가능 합니다.";
  }
  return text;
}

function activityAll(){
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "All Activity";
  } else if($.cookie("langCode") == "ja"){
    text = "すべての事業活動";
  } else if($.cookie("langCode") == "zh"){
    text = "所有的商业活动";
  } else {
    text = "전체업무활동";
  }
  return text;
}

function activityWithTask(){
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Activity with a task";
  } else if($.cookie("langCode") == "ja"){
    text = "タスクを含むビジネスログ";
  } else if($.cookie("langCode") == "zh"){
    text = "业务活动与任务";
  } else {
    text = "부탁이 있는 업무활동";
  }
  return text;
}

function activityWithNotConfirmedTask(){
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Activity with task before confirmed";
  } else if($.cookie("langCode") == "ja"){
    text = "確認される前のタスクのアクティビティ";
  } else if($.cookie("langCode") == "zh"){
    text = "业务活动与任务之前确认";
  } else {
    text = "확인 전 부탁이 있는 업무활동";
  }
  return text;
}

function activityWithChatting(){
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Activity with chatting";
  } else if($.cookie("langCode") == "ja"){
    text = "チャットでのアクティビティ";
  } else if($.cookie("langCode") == "zh"){
    text = "与聊天的活动";
  } else {
    text = "채팅이 있는 업무활동";
  }
  return text;
}

function canNotExit(){
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "The chat room associated with the Business Log does not support leaving.";
  } else if($.cookie("langCode") == "ja"){
    text = "ジャーナルに関連付けられたチャットルームは終了をサポートしていません。";
  } else if($.cookie("langCode") == "zh"){
    text = "与日记有关的聊天室不支持自己。";
  } else {
    text = "업무일지와 연결된 채팅방은 나가기 를 지원하지 않습니다.";
  }
  return text;
}

function groupNameDuplicate(){
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Duplicate group name.";
  } else if($.cookie("langCode") == "ja"){
    text = "グループ名が重複しています。";
  } else if($.cookie("langCode") == "zh"){
    text = "该组的名称被复制。";
  } else {
    text = "그룹 이름이 중복되었습니다.";
  }
  return text;
}

function inputBusineesContents(){
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Please write business contents.";
  } else if($.cookie("langCode") == "ja"){
    text = "事業内容を書いてください。";
  } else if($.cookie("langCode") == "zh"){
    text = "请填写你的职位描述。";
  } else {
    text = "업무내용을 적어주세요.";
  }
  return text;
}

function errorFileUpload(){
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Failed to attach file.";
  } else if($.cookie("langCode") == "ja"){
    text = "ファイル添付に失敗しました。";
  } else if($.cookie("langCode") == "zh"){
    text = "失败文件附件。";
  } else {
    text = "파일 첨부를 실패하였습니다.";
  }
  return text;
}

function errorCreateActivity(){
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Create Business Log failed.";
  } else if($.cookie("langCode") == "ja"){
    text = "ジャーナルの作成に失敗しました。";
  } else if($.cookie("langCode") == "zh"){
    text = "写日记失败。";
  } else {
    text = "업무일지 작성을 실패하였습니다.";
  }
  return text;
}

function inputEmptyValue(){
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Fill in the blank values.";
  } else if($.cookie("langCode") == "ja"){
    text = "空の値を利用してください。";
  } else if($.cookie("langCode") == "zh"){
    text = "请在空值填充。";
  } else {
    text = "빈 값을 채워주세요.";
  }
  return text;
}

function errorTryAgain(){
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Failed. Try it in a minute.";
  } else if($.cookie("langCode") == "ja"){
    text = "失敗しました。しばらく試してみてください。";
  } else if($.cookie("langCode") == "zh"){
    text = "失败。请稍后再试。";
  } else {
    text = "실패하였습니다. 잠시 후에 시도 해 보세요";
  }
  return text;
}

function onlyOneRoom(){
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Only one room per activity can be created.";
  } else if($.cookie("langCode") == "ja"){
    text = "活動の1つに1つのチャットルームのみを生成できます。";
  } else if($.cookie("langCode") == "zh"){
    text = "您可以创建一个聊天室只有一个活动。";
  } else {
    text = "활동1개에 1개의 채팅방만 생성 가능합니다.";
  }
  return text;
}

function isNotGroupUser(){
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "This user does not belong to the current group.";
  } else if($.cookie("langCode") == "ja"){
    text = "そのユーザーは、現在のグループに属していません。";
  } else if($.cookie("langCode") == "zh"){
    text = "这个人不属于当前组。";
  } else {
    text = "해당 사용자는 현재 그룹에 속해있지 않습니다.";
  }
  return text;
}


function selectGroupMember(){
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Please select group member.";
  } else if($.cookie("langCode") == "ja"){
    text = "グループ員を選択してください。";
  } else if($.cookie("langCode") == "zh"){
    text = "请选择组成员。";
  } else {
    text = "그룹원을 선택해주세요";
  }
  return text;
}

function onlyImageFile(){
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Only image files are available.";
  } else if($.cookie("langCode") == "ja"){
    text = "イメージファイルのみ可能です。";
  } else if($.cookie("langCode") == "zh"){
    text = "你只能图像文件。";
  } else {
    text = "이미지 파일만 가능합니다.";
  }
  return text;
}

function enterGroupName(){
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Please enter a group name.";
  } else if($.cookie("langCode") == "ja"){
    text = "グループ名を入力してください。";
  } else if($.cookie("langCode") == "zh"){
    text = "该组输入名称。";
  } else {
    text = "그룹 이름을 입력 해 주세요.";
  }
  return text;
}

function enterMapTitle(){
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Please enter map title and content.";
  } else if($.cookie("langCode") == "ja"){
    text = "マップタイトルと内容を入力してください。";
  } else if($.cookie("langCode") == "zh"){
    text = "请输入标题和地图信息。";
  } else {
    text = "맵 이름과 내용을 입력해주세요.";
  }
  return text;
}

function addEmail(){
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Add an email.";
  } else if($.cookie("langCode") == "ja"){
    text = "メールを追加してください。";
  } else if($.cookie("langCode") == "zh"){
    text = "添加一个电子邮件。";
  } else {
    text = "이메일을 추가하세요.";
  }
  return text;
}

function sentInvitationEmail(){
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "You have sent an invitation email.";
  } else if($.cookie("langCode") == "ja"){
    text = "招待メールを送信しました。";
  } else if($.cookie("langCode") == "zh"){
    text = "邀请电子邮件已发送。";
  } else {
    text = "초대 이메일을 전송하였습니다.";
  }
  return text;
}

function alreadyLeft(){
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "User who has already left.";
  } else if($.cookie("langCode") == "ja"){
    text = "すでに脱退したユーザです。";
  } else if($.cookie("langCode") == "zh"){
    text = "用户已经分裂。";
  } else {
    text = "이미 탈퇴한 유저입니다.";
  }
  return text;
}

function enterAgain(){
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Please enter your username and password again.";
  } else if($.cookie("langCode") == "ja"){
    text = "ユーザ名とパスワードを再入力してください。";
  } else if($.cookie("langCode") == "zh"){
    text = "请输入您的用户名和密码。";
  } else {
    text = "아이디와 비밀번호를 다시 입력해주세요.";
  }
  return text;
}

function checkIdDuplication(){
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Please check ID duplication.";
  } else if($.cookie("langCode") == "ja"){
    text = "ユーザ名の重複チェックをしてください。";
  } else if($.cookie("langCode") == "zh"){
    text = "请检查您的ID重复。";
  } else {
    text = "아이디 중복체크를 해주세요.";
  }
  return text;
}

function fillEmailFormat(){
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Fill in the email format.";
  } else if($.cookie("langCode") == "ja"){
    text = "電子メールの形式に合わせて記入してください。";
  } else if($.cookie("langCode") == "zh"){
    text = "请在邮件的形式配合填写。";
  } else {
    text = "이메일 형식에 맞게 기입하세요.";
  }
  return text;
}

function acceptPrivacyPolicy(){
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Please accept the privacy policy.";
  } else if($.cookie("langCode") == "ja"){
    text = "プライバシーポリシーに同意してください。";
  } else if($.cookie("langCode") == "zh"){
    text = "请接受隐私政策。";
  } else {
    text = "개인정보취급방침에 동의 해주세요";
  }
  return text;
}

function agreeTerms(){
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Please agree to the terms and conditions.";
  } else if($.cookie("langCode") == "ja"){
    text = "利用規約に同意してください。";
  } else if($.cookie("langCode") == "zh"){
    text = "请同意条款和条件。";
  } else {
    text = "이용약관에 동의 해 주세요.";
  }
  return text;
}

function emailAlreadyUse(){
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Your current email is already in use.";
  } else if($.cookie("langCode") == "ja"){
    text = "現在の電子メールは、すでに使用中です。";
  } else if($.cookie("langCode") == "zh"){
    text = "此电子邮件已被使用。";
  } else {
    text = "현재 이메일은 이미 사용중입니다.";
  }
  return text;
}

function inEditMode(){
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "In Edit mode, only one person can be selected.";
  } else if($.cookie("langCode") == "ja"){
    text = "修正モードでは、1人だけ選択することができます。";
  } else if($.cookie("langCode") == "zh"){
    text = "在编辑模式下，你只能选择一个。";
  } else {
    text = "수정 모드에서는 1명만 선택 할 수 있습니다.";
  }
  return text;
}

function passwordDoNotMatch(){
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Passwords do not match.";
  } else if($.cookie("langCode") == "ja"){
    text = "パスワードが一致しません。";
  } else if($.cookie("langCode") == "zh"){
    text = "密码不匹配。";
  } else {
    text = "비밀번호가 일치하지 않습니다.";
  }
  return text;
}

function withdrawalComplete(){
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Your withdrawal is complete.";
  } else if($.cookie("langCode") == "ja"){
    text = "退会が完了しました。";
  } else if($.cookie("langCode") == "zh"){
    text = "撤出已经完成。";
  } else {
    text = "탈퇴가 완료되었습니다.";
  }
  return text;
}

function permission_denied(){
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Permission denied.";
  } else if($.cookie("langCode") == "ja"){
    text = "アクセスが拒否されました。";
  } else if($.cookie("langCode") == "zh"){
    text = "权限被拒绝。";
  } else {
    text = "권한이 없습니다.";
  }
  return text;
}

function leaveChat(){
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Are you sure you want to leave the chat room?";
  } else if($.cookie("langCode") == "ja"){
    text = "チャットルームを私がしたいですか？";
  } else if($.cookie("langCode") == "zh"){
    text = "你确定要离开聊天室？";
  } else {
    text = "채팅방을 나가시겠습니까?";
  }
  return text;
}

function mapInvite(){
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Would you like to invite?";
  } else if($.cookie("langCode") == "ja"){
    text = "招待しますか？";
  } else if($.cookie("langCode") == "zh"){
    text = "你想邀请？";
  } else {
    text = "초대하시겠습니까?";
  }
  return text;
}

function mapLeave(){
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Would you like to leave?";
  } else if($.cookie("langCode") == "ja"){
    text = "退場させますか？";
  } else if($.cookie("langCode") == "zh"){
    text = "你想离开？";
  } else {
    text = "퇴장 시키겠습니까?";
  }
  return text;
}

function noUser(){
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "There are no users.";
  } else if($.cookie("langCode") == "ja"){
    text = "ユーザーがありません。";
  } else if($.cookie("langCode") == "zh"){
    text = "没有用户。";
  } else {
    text = "유저가 없습니다.";
  }
  return text;
}

function adminNotAllow(){
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Administrators are not allowed to leave.";
  } else if($.cookie("langCode") == "ja"){
    text = "管理者は、退場はできません。";
  } else if($.cookie("langCode") == "zh"){
    text = "管理员可以不被解雇。";
  } else {
    text = "그룹 관리자는 퇴장이 불가능합니다.";
  }
  return text;
}

function selectValidDate(){
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Please select a valid date range.";
  } else if($.cookie("langCode") == "ja"){
    text = "有効な期間を選択してください。";
  } else if($.cookie("langCode") == "zh"){
    text = "请选择一个有效的时期。";
  } else {
    text = "유효한 기간을 선택 해 주세요.";
  }
  return text;
}

function onlyChatMembers(){
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Only chat members can join.";
  } else if($.cookie("langCode") == "ja"){
    text = "チャットルームのメンバーのみ参加可能です。";
  } else if($.cookie("langCode") == "zh"){
    text = "只有会员可以参加聊天室。";
  } else {
    text = "채팅방 구성원만 참여 가능 합니다.";
  }
  return text;
}

function forceLeaveMap() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Would you like to force it out of the map?";
  } else if($.cookie("langCode") == "ja"){
    text = "マップで強制的に退場しますか？";
  } else if($.cookie("langCode") == "zh"){
    text = "你确定你想踢给力的地图？";
  } else {
    text = "맵에서 강제로 퇴장 시키시겠습니까?";
  }
  return text;
}

function writeTheNotice() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Please write the notice.";
  } else if($.cookie("langCode") == "ja"){
    text = "公知の内容を記入してください。";
  } else if($.cookie("langCode") == "zh"){
    text = "请注意通知。";
  } else {
    text = "공지 내용을 적어주세요";
  }
  return text;
}

function initializeMap() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Do you really want to initialize it?";
  } else if($.cookie("langCode") == "ja"){
    text = "本当に初期化しますか？";
  } else if($.cookie("langCode") == "zh"){
    text = "您确定要初始化？";
  } else {
    text = "정말 초기화 하시겠습니까?";
  }
  return text;
}

function selectMap() {
  var text = "";
  if($.cookie("langCode") == "en"){
    text = "Please select 'Map@Group'";
  } else if($.cookie("langCode") == "ja"){
    text = "'Map@Group' を選択してください";
  } else if($.cookie("langCode") == "zh"){
    text = "请选择年份 'Map@Group'";
  } else {
    text = "'Map@Group'을 선택 해 주세요";
  }
  return text;
}
