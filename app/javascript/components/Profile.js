import React from "react";
import ReactDOM from "react-dom";

class Profile extends React.Component {
  render() {
    const { email, firstname, lastname, timezone, url } = this.props.profile;

    // coming from fetch of profile (find where(url = {url}))
    const host = window.location.origin;

    // local host will change on deployment
    const my_url = `${host}/profile/${url}`;

    return (
      <div id="staticprofile">
        <h1>My Profile</h1>
        <h2 id="fullname">
          {firstname} {lastname}
        </h2>
        <h3 id="email">{email}</h3>
        <h3 id="timezone">{timezone}</h3>
        <h3 id="url">{my_url}</h3>
      </div>
    );
  }
}

export default Profile;
