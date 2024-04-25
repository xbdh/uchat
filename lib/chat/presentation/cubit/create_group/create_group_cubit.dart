import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uchat/app/constants/firebase_collection.dart';
import 'package:uuid/uuid.dart';

import '../../../domain/entities/group_entity.dart';
import '../../../domain/use_cases/create_group_usecase.dart';
import '../../../domain/use_cases/store_file_usecase.dart';

part 'create_group_state.dart';

class CreateGroupCubit extends Cubit<CreateGroupState> {
  final CreateGroupUseCase createGroupUseCase;
  final StoreFileUseCase storeFileUseCase;
  List<String> membersUIDs = [];
  List<String> adminsUIDs = [];

  void addMember(String uid) {
    membersUIDs.add(uid);
  }
  void addAdmin(String uid) {
    adminsUIDs.add(uid);
  }
  void removeMember(String uid) {
    membersUIDs.remove(uid);
  }
  void removeAdmin(String uid) {
    adminsUIDs.remove(uid);
  }

  get members => membersUIDs;
  get admins => adminsUIDs;

  CreateGroupCubit({
    required this.createGroupUseCase,
    required this.storeFileUseCase,
  }) : super(CreateGroupInitial());

  Future<void> createGroup (GroupEntity groupEntity,File imageFile) async {



    emit(CreateGroupLoading());
    try {

      final groupId =const Uuid().v4();
      final reference = "${FirebaseCollectionManager.groups}/$groupId";
      final String imageUrl = await storeFileUseCase(imageFile, reference);

      // union membersUIDs in finalGroupEntity and groupEntity
      // 相当于加入我自己
      List<String> finalMembersUIDs = [];
      List<String> finalAdminsUIDs = [];
      finalMembersUIDs.addAll(groupEntity.membersUIDs);
      finalMembersUIDs.addAll(membersUIDs);
      finalAdminsUIDs.addAll(groupEntity.adminsUIDs);
      finalAdminsUIDs.addAll(adminsUIDs);

      GroupEntity finalGroupEntity = groupEntity.copyWith(
        groupId: groupId,
        groupImage: imageUrl,
        membersUIDs: finalMembersUIDs,
        adminsUIDs: finalAdminsUIDs,
      );

      await createGroupUseCase(finalGroupEntity);
      emit(CreateGroupSuccess());
    } catch (e) {
      emit(CreateGroupFailed());
    }
  }

}
