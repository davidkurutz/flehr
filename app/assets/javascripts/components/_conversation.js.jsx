function Conversation(props) {
  return (
    <div className='conversation' data-id={props.id} onClick={props.onConversationClicked}>{props.recipient}</div>
  );
}