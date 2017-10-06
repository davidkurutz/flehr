function NewConversationForm(props) {
  let options = props.users.map(function(user, idx) {
    return <option key={idx} value={user.id}>{user.username}</option>
  })
  return (
    <div className='conversation button-container'>
      <form onSubmit={props.createConversation} method='post' action="#">
        <select required name="recipient_id" >
          <option value="">Select user</option>
          {options}
        </select>
        <input type='submit' value='New Chat' className='btn btn-default new-conversation'/>
      </form>
    </div>
  );
}