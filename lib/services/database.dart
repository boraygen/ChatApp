import 'package:chat_app/models/friend_model.dart';
import 'package:chat_app/services/data_strings.dart';
import 'package:chat_app/shared/widgets.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Database
{

  final String uid;
  Database({this.uid});

  //final storage = FirebaseStorage.instance.ref();
  final CollectionReference userCollection = FirebaseFirestore.instance.collection(cUsers);
  final CollectionReference chatRoomCollection = FirebaseFirestore.instance.collection(cChatRooms);

  //StorageReference spaceRef = storageRef.child("images/space.jpg");
  

  getUserByUsername(String query) async
  {
    // final QuerySnapshot usernameResult = await userCollection
    // .where("username", : username)
    // .get();
    // final List<DocumentSnapshot> usernameAndIdDocs = usernameResult.docs;
    var documentList = await userCollection
    .where(fUsername, isGreaterThanOrEqualTo: query)
    .get();

    final List<DocumentSnapshot> queryDocs = documentList.docs;
  }

  // check if user has set username
  Future<bool> doesDocExist(UserModel user) async 
  {
    try 
    {
      var doc = await userCollection.doc(user.uid).get();
      return doc.exists;
    } 
    catch (e) 
    {
      rethrow;
    }
  }

  // // get profile picture
  // Future getProfilePicture(String path) async
  // {
  //   final storage = FirebaseStorage.instance.ref(path);
  //   return await storage.listAll();
    
  // }

  // check if username and id exist
  Future<bool> doesUsernameAndIdAlreadyExist(String username, String usernameId) async {
    final QuerySnapshot usernameResult = await userCollection
      .where(fUsername, isEqualTo: username)
      .where(fUsernameId, isEqualTo: usernameId)
      .get();
    final List<DocumentSnapshot> usernameAndIdDocs = usernameResult.docs;

    return (usernameAndIdDocs.isEmpty) ? false : true;
  }


  // create user
  Future createUser(String username, String usernameId) async
  {
    //Random random = Random();
    
    return await userCollection.doc(uid).set(
      {
        fUid: uid,
        fUsername: username,
        fUsernameId: usernameId,
        fStatus: "Hey there!",
        //"pictureRef": "dummyChatLogo" "${random.nextInt(8)}" ".png",
        fFriendRequests: [],
        fFriendsUid: [],
        fBlocked: []
      }
    );
  }

  // update user status
  Future updateStatus(String status) async
  {
    return await userCollection.doc(uid).update(
      {
        fStatus: status,
      }
    );
  }

  // set username and id - DUMMY
  Future setUsernameAndId(String username, String usernameId) async
  {
    return await userCollection.doc(uid).set(
      {
        "username": username,
        "usernameId": usernameId,
      }
    );
  }


  // get users
  Stream<List<UserModel>> get users
  {
    return userCollection.snapshots().map(
      (QuerySnapshot snapshot)
      {
        return snapshot.docs.map((doc)
        {
          return UserModel(
            uid: uid,
            username: doc.get(fUsername),
            usernameId: doc.get(fUsernameId), 
            status: doc.get(fStatus),
            friendsUid: List.from(doc.get(fFriendsUid)),
            friendRequests: List.from(doc.get(fFriendRequests)),
            blocked: List.from(doc.get(fBlocked)),

          );
        }).toList();
      }
    );
  }

  // get current user
  Stream<UserModel> get currentUser
  {
    return userCollection.doc(uid).snapshots().map(
      (DocumentSnapshot snapshot)
      {
        return UserModel(
          uid: uid,
          username: snapshot.get(fUsername),
          usernameId: snapshot.get(fUsernameId), 
          status: snapshot.get(fStatus),
          friendsUid: List.from(snapshot.get(fFriendsUid)),
          //friends: Database(uid: uid).friends,
          friendRequests: List.from(snapshot.get(fFriendRequests)),
          blocked: List.from(snapshot.get(fBlocked)),
        );
      }
    );
  }

  // get current user's friends - DUMMY
  Stream<List<FriendModel>> get friends
  {
    return userCollection.snapshots().map(
      (QuerySnapshot snapshot)
      {
        return snapshot.docs.map((doc)
        {
          return FriendModel(
            uid: uid,
            username: doc.get(fUsername),
            usernameId: doc.get(fUsernameId), 
            status: doc.get(fStatus),

          );
        }).toList();
      }
    );
  }
  // Stream<FriendModel> get friendsff
  // {
  //   return userCollection.doc(uid).snapshots().map(
  //     (DocumentSnapshot snapshot)
  //     {
  //       return FriendModel(
  //         uid: uid,
  //         username: snapshot.get(fUsername),
  //         usernameId: snapshot.get(fUsernameId), 
  //         status: snapshot.get(fStatus),
  //       );
  //     }
  //   );
  // }

  // create chat room - DUMMY
  Future createChatRoom(String roomName, List users) async
  {
    return await chatRoomCollection.doc(uid).set(
      {
        fCreatedBy: uid,
        fRoomName: roomName,
        fUsers: "",
      }
    );
  }

  // send friend request
  Future sendFriendRequest({BuildContext context, String username, String usernameId}) async {
    // get user uid which the request has been sent
    final QuerySnapshot result = await userCollection
      .where(fUsername, isEqualTo: username)
      .where(fUsernameId, isEqualTo: usernameId)
      .get();
    final List<DocumentSnapshot> requestedUser = result.docs;
   
    // check if the requested user exists
    if (requestedUser.isNotEmpty)
    {
      var requestedUserUid = await requestedUser[0].get("uid");
      if(uid == requestedUserUid) // if user self-requested
      {
        customSnackBar(
          context: context,
          type: -1,
          text: "You cannot request yourself, naturally."
        );
        return null;
      }
      // check the current user's friend list
      var currentUser = await userCollection.doc(uid).get();
      List userFriends = await currentUser.get(fFriendsUid);
      List userFriendRequests = await currentUser.get(fFriendRequests);

      if(userFriends.contains(requestedUserUid))
      { // if the users are already friends
        customSnackBar(
          context: context,
          type: 0,
          text: "You are already friends."
        );
        return null;
      }
      else if(userFriendRequests.contains(requestedUserUid))
      { // if requested user has already sent a request to current user
        return await acceptFriendRequest(requestedUserUid);
      }
      else
      { // if they are not friends

        // check current user's sent friend requests
        var requestedUser = await userCollection.doc(requestedUserUid).get();
        List requestedUserFriendRequests = await requestedUser.get(fFriendRequests);
        if(requestedUserFriendRequests.contains(uid))
        { // if request already sent
          customSnackBar(
            context: context,
            type: 0,
            text: "Friend request is already sent."
          );
          return null;
        }
        else
        { // if no request sent yet
          customSnackBar(
            context: context, 
            type: 1, 
            text: "Friend request sent!"
          );
          return await userCollection.doc(requestedUserUid).update(
            {
              fFriendRequests: FieldValue.arrayUnion([uid]),
            }
          );
        }
      }
    }
    else
    { // username id pair doesn't exist
      customSnackBar(
        context: context,
        type: 0,
        text: "No user found."
      );
      return null;
    }
  }

  // accept friend request
  Future acceptFriendRequest(String requestedUserUid) async
  {
    return // update both users' friend lists
    {
      await userCollection.doc(uid).update(
        {
          fFriendsUid: FieldValue.arrayUnion([requestedUserUid]),
          fFriendRequests: FieldValue.arrayRemove([requestedUserUid]),
        }
      ),
      await userCollection.doc(requestedUserUid).update(
        {
          fFriendsUid: FieldValue.arrayUnion([uid]),
        }
      ),
    };
  }
  
  // reject friend request
  Future rejectFriendRequest(String requestedUserUid) async
  {
    return await userCollection.doc(uid).update(
      {
        fFriendRequests: FieldValue.arrayRemove([requestedUserUid]),
      }
    );
  }

  // remove friend
  Future removeFriend(BuildContext context, String requestedUserUid) async
  {
    if(context == null)
    {
      customSnackBar(
        context: context, 
        type: 1, 
        text: "You are no longer friends."
      );
    }
    
    return // update both users' friend lists
    {
      await userCollection.doc(uid).update(
        {
          fFriendsUid: FieldValue.arrayRemove([requestedUserUid]) ,
        }
      ),
      await userCollection.doc(requestedUserUid).update(
        {
          fFriendsUid: FieldValue.arrayRemove([uid]),
        }
      ),
    };
  }

  // block user
  Future blockUser(String requestedUserUid) async
  {
    var currentUser = await userCollection.doc(uid).get();
    var requestedUser = await userCollection.doc(requestedUserUid).get();
    List userFriends = await currentUser.get(fFriendsUid);
    List userFriendRequests = await currentUser.get(fFriendRequests);
    List requestedUserFriendRequests = await requestedUser.get(fFriendRequests);

    if(userFriends.contains(requestedUserUid)) // if friends, remove
    {
      await removeFriend(null, requestedUserUid);
    }
    if(userFriendRequests.contains(requestedUserUid)) // if friend request exists, remove
    {
      await rejectFriendRequest(requestedUserUid);
    }
    if(requestedUserFriendRequests.contains(uid)) // if user has requested to be friends, remove
    {
      await userCollection.doc(requestedUserUid).update(
        {
          fFriendRequests: FieldValue.arrayRemove([uid]),
        }
      );
    }

    return // update user's blocked list
    {
      await userCollection.doc(uid).update(
        {
          fBlocked: FieldValue.arrayUnion([requestedUserUid]),
        }
      ),
    };
  }

  // unblock user
  Future unblockUser(String requestedUserUid) async
  {
    return // update user's blocked list
    {
      await userCollection.doc(uid).update(
        {
          fBlocked: FieldValue.arrayRemove([requestedUserUid]),
        }
      ),
    };
  }

  Future test() async
  {
    return await -1;
  }
}
