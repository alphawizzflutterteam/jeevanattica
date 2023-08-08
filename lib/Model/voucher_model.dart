class VoucherModel{
  String id,promo_code,message,start_date,end_date,no_of_users,minimum_order_amount,discount,
      discount_type,max_discount_amount,repeat_usage,no_of_repeat_usage,status,date_created,image;
  VoucherModel(
      this.id,
      this.promo_code,
      this.message,
      this.start_date,
      this.end_date,
      this.no_of_users,
      this.minimum_order_amount,
      this.discount,
      this.discount_type,
      this.max_discount_amount,
      this.repeat_usage,
      this.no_of_repeat_usage,
      this.status,
      this.date_created,this.image);
}
class NotificationModel{
  String id,name,subtitle,type,type_id,image;

  NotificationModel(
      this.id, this.name, this.subtitle, this.type, this.type_id, this.image);
}