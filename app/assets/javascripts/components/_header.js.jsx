function Header(props) {
  return (
    <div className="row header">
      <h5>Logged in as {props.username}</h5>
      <LogOutButton />
    </div>
  );
}
