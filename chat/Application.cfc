component {
  this.name = "ChatApp";
  this.sessionManagement = false;

  boolean function onApplicationStart() output=false {
    Application.rooms = {};
    Application.rooms["general"] = {};
    Application.clients = {};
    return true;
  }
}

