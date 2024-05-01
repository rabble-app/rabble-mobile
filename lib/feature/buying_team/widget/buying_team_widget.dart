import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:rabble/core/config/export.dart';
import 'package:rabble/domain/entities/UserTeamModel.dart';
import 'package:rabble/feature/buying_team/widget/buying_team_item_shimmer.dart';

import '../../../domain/entities/RequestSendModel.dart';

class BuyingTeamWidget extends StatefulWidget {
  final bool isHorizontal;
  final List<dynamic> teamList;
  final String heading;
  final bool showViewAll;
  final bool? showLoader;
  final String? id;
  final VoidCallback callBackIfUpdated;

  const BuyingTeamWidget(
      {Key? key,
      required this.isHorizontal,
      this.showLoader,
      required this.teamList,
      required this.heading,
      required this.showViewAll,
      this.id,
      required this.callBackIfUpdated})
      : super(key: key);

  @override
  State<BuyingTeamWidget> createState() => _BuyingTeamWidgetState();
}

class _BuyingTeamWidgetState extends State<BuyingTeamWidget> {
  @override
  Widget build(BuildContext ctx) {
    if (widget.showLoader != null && widget.showLoader!) {
      if (widget.isHorizontal) {
        return Column(
          children: [
            widget.heading.isNotEmpty &&
                    widget.showViewAll &&
                    widget.teamList.isNotEmpty
                ? Container(
                    margin: PagePadding.custom(3.w, 3.w, 0, 0),
                    child: ViewAllWidget(
                      title: widget.heading,
                      showViewAllBtn: widget.showViewAll,
                      callback: () {},
                    ),
                  )
                : const SizedBox.shrink(),
            SizedBox(
              height: 1.h,
            ),
            SizedBox(
              height: context.allHeight * 0.3,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return const BuyingTeamItemShimmer();
                  }),
            ),
          ],
        );
      } else {
        return Column(
          children: [
            Container(
              margin: PagePadding.custom(3.w, 3.w, 0, 0),
              child: ViewAllWidget(
                title: widget.heading,
                showViewAllBtn: widget.showViewAll,
                callback: () {},
              ),
            ),
            ListView.builder(
                itemCount: 10,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return const BuyingTeamItemShimmer();
                }),
          ],
        );
      }
    }

    if (widget.isHorizontal) {
      return Column(
        children: [
          widget.heading.isNotEmpty &&
                  widget.showViewAll &&
                  widget.teamList.isNotEmpty
              ? Container(
                  margin: PagePadding.custom(3.w, 3.w, 0, 0),
                  child: ViewAllWidget(
                    title: widget.heading,
                    showViewAllBtn: widget.showViewAll,
                    callback: () {
                      NavigatorHelper()
                          .navigateTo('/all_buying_teams_view', {});
                    },
                  ),
                )
              : const SizedBox.shrink(),
          SizedBox(
            height: 0.5.h,
          ),
          SizedBox(
            height: context.allHeight * 0.42,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.teamList.length,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  var data = widget.teamList[index];
                  return BuyingTeamItemWidget(
                    isVertical: widget.isHorizontal,
                    teamId: data.id,
                    image: data.imageUrl ?? '',
                    teamName: data.name,
                    postalCode: data.postalCode ?? '',
                    busniessName: data.producer!.businessName,
                    status: widget.id == data.hostId
                        ? ''
                        : getStatus(widget.teamList[index].members,
                            widget.teamList[index].requests),
                    frequency: Conversation.getFrequencyText(data.frequency),
                    category: data.producer!.categories != null &&
                            data.producer!.categories!.isNotEmpty &&
                            data.producer!.categories!.first.category != null
                        ? data.producer!.categories!.first.category!.name
                        : '',
                    nextDelivery: DateFormatUtil.getNextDeliveryDate(
                        data.nextDeliveryDate, data.frequency!.toInt()),
                    producerName:
                        '${data.host!.firstName ?? ''} ${data.host!.lastName ?? ''}',
                    totalTeamMembers: data.members == null
                        ? '0'
                        : data.members!.length.toString(),
                    hostName:
                        '${data.host!.firstName ?? ''} ${data.host!.lastName ?? ''}',
                    callBackIfUpdated: () {
                      widget.callBackIfUpdated.call();
                    },
                    callBack: () {
                      if (data.basket!.isEmpty) {
                        ProducerDetail producerDetail = ProducerDetail(
                            imageUrl: data.producer!.imageUrl,
                            id: data.producer!.id,
                            businessName: data.producer!.businessName,
                            businessAddress: data.producer!.businessAddress,
                            website: data.producer!.website,
                            categories: data.producer!.categories!,
                            count: data.producer!.count);

                        Map body = {
                          'type': true,
                          'data': producerDetail,
                          'id': producerDetail.id,
                          'team': TeamData(
                            id: data.id,
                            name: data.name,
                            producerId: data.producerId,
                          )
                        };
                        BuyingTeamCreationService().addTeamCreationData(
                            mFrequency, data.frequency.toInt());
                        RabbleStorage().setInivitationData(json.encode(
                            InvitationData(
                                producerInfo: data.producer,
                                teamId: data.id,
                                teamName: data.name)));

                        NavigatorHelper().navigateTo('/producer', body);
                      } else {
                        Map map = {
                          'teamId': data.id,
                          'type': '1',
                          'teamName': data.name
                        };

                        Navigator.pushNamed(context, '/threshold_view',
                                arguments: map)
                            .then((value) {
                          widget.callBackIfUpdated.call();
                        });
                      }
                    },
                  );
                }),
          ),
        ],
      );
    }

    return widget.heading.isNotEmpty &&
            widget.showViewAll &&
            widget.teamList.isNotEmpty
        ? ListView.builder(
            itemCount: widget.teamList.length,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              BuyingTeamDetail data = widget.teamList[index];
              print("widget.id == data.hostId? ${widget.id} ${data.hostId}");
              return BuyingTeamItemWidget(
                isVertical: widget.isHorizontal,
                teamId: data.id,
                teamName: data.name,
                postalCode: data.postalCode ?? '',
                image: data.imageUrl,
                busniessName: data.producer!.businessName,
                status: widget.id == data.hostId
                    ? ''
                    : getStatus(widget.teamList[index].members,
                        widget.teamList[index].requests),
                frequency:
                    Conversation.getFrequencyText(data.frequency!.toInt()),
                category: data.producer!.categories != null &&
                        data.producer!.categories!.isNotEmpty &&
                        data.producer!.categories!.first.category != null
                    ? data.producer!.categories!.first.category!.name
                    : '',
                nextDelivery: DateFormatUtil.getNextDeliveryDate(
                    data.nextDeliveryDate, data.frequency!.toInt()),
                producerName:
                    '${data.host!.firstName ?? ''} ${data.host!.lastName ?? ''}',
                totalTeamMembers: data.members == null
                    ? '0'
                    : data.members!.length.toString(),
                hostName:
                    '${data.host!.firstName ?? ''} ${data.host!.lastName ?? ''}',
                callBackIfUpdated: () {
                  widget.callBackIfUpdated.call();
                },
              );
            })
        : Column(
            children: [
              widget.showViewAll
                  ? ViewAllWidget(
                      title: widget.heading,
                      showViewAllBtn: widget.showViewAll,
                      callback: () {
                        NavigatorHelper()
                            .navigateTo('/all_buying_teams_view', {});
                      },
                    )
                  : const SizedBox.shrink(),
              ListView.builder(
                  itemCount: widget.teamList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    dynamic data;
                    if (widget.teamList is List<BuyingTeamDetail>) {
                      data = widget.teamList[index] as BuyingTeamDetail;
                    } else {
                      var temp = widget.teamList[index] as HostTeamData;

                      data = temp.team;
                    }

                    return BuyingTeamItemWidget(
                      isVertical: widget.isHorizontal,
                      teamId: data.id,
                      teamName: data.name,
                      postalCode: data.postalCode ?? '',
                      image: data.imageUrl,
                      status: widget.id == data.hostId
                          ? ''
                          : widget.teamList[index].members != null
                              ? getStatus(widget.teamList[index].members,
                                  widget.teamList[index].requests)
                              : '',
                      busniessName: data.producer!.businessName,
                      frequency: Conversation.getFrequencyText(data.frequency),
                      category: data.producer!.categories != null &&
                              data.producer!.categories!.isNotEmpty &&
                              data.producer!.categories!.first.category != null
                          ? data.producer!.categories!.first.category!.name
                          : '',
                      nextDelivery: DateFormatUtil.getNextDeliveryDate(
                          data.nextDeliveryDate, data.frequency!.toInt()),
                      producerName:
                          '${data.host!.firstName ?? ''} ${data.host!.lastName ?? ''}',
                      totalTeamMembers: data.members == null
                          ? '0'
                          : data.members!.length.toString(),
                      hostName:
                          '${data.host!.firstName ?? ''} ${data.host!.lastName ?? ''}',
                      callBackIfUpdated: () {
                        widget.callBackIfUpdated.call();
                      },
                      callBack: () {
                        if (data.basket == null || data.basket!.isEmpty) {
//                        if (data.basket != null && data.basket!.isEmpty) {
                          ProducerDetail producerDetail = ProducerDetail(
                              imageUrl: data.producer!.imageUrl,
                              id: data.producer!.id,
                              businessName: data.producer!.businessName,
                              businessAddress: data.producer!.businessAddress,
                              website: data.producer!.website,
                              categories: data.producer!.categories!,
                              count: data.producer!.count);

                          BuyingTeamCreationService().addTeamCreationData(
                              mFrequency, data.frequency.toInt());
                          Map body = {
                            'type': true,
                            'data': producerDetail,
                            'id': producerDetail.id,
                            'team': TeamData(
                              id: data.id,
                              name: data.name,
                              frequency: data.frequency.toInt(),
                              producerId: data.producerId,
                            )
                          };

                          RabbleStorage().setInivitationData(json.encode(
                              InvitationData(
                                  producerInfo: data.producer,
                                  teamId: data.id,
                                  teamName: data.name)));

                          NavigatorHelper().navigateTo('/producer', body);
                        } else {
                          Map map = {
                            'teamId': data.id,
                            'type': '1',
                            'teamName': data.name
                          };

                          Navigator.pushNamed(context, '/threshold_view',
                                  arguments: map)
                              .then((value) {
                            widget.callBackIfUpdated.call();
                          });
                        }
                      },
                    );
                  }),
            ],
          );
  }

  getStatus(List<BuyingTeamMembers>? members, List<RequestSendData>? requests) {
    BuyingTeamMembers? member = members!.firstWhere(
        (element) => element.userId == widget.id,
        orElse: () => BuyingTeamMembers());
    if (member != null && member.id != null) {
      return member.status;
    } else {
      if (requests != null) {
        RequestSendData? request = requests.firstWhere(
            (element) => element.userId == widget.id,
            orElse: () => RequestSendData());
        if (request != null && request.id != null) {
          return request.status;
        } else
          return '';
      }

      return '';
    }
  }



}
