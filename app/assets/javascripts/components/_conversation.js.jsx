function Conversation(props) {
  let classString = "conversation" + " " + props.className;
  return (
    <div
      className={classString}
      data-id={props.id}
      onClick={props.onConversationClicked}>{props.recipient}
    </div>
  );
}