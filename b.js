const
    {
        history,
        receipt,
        register
    } = input;

var reg = db_save("constructionregistration", register, true)

// throw(to_json(history))

if (receipt != null && register['status'] === "WAIT_PAY") {
    for (let i of receipt) {
        i['refId'] = reg["_id"]
        i['refSchema'] = 'ConstructionRegistration'
        i['content'] =
            `Thanh toán phí ${i["type"] === "ContructionCost" ? "thi công" : "đặt cọc"} mã ${reg['code']}`
        i['reason'] =
            `Thanh toán phí ${i["type"] === "ContructionCost" ? "thi công" : "đặt cọc"} mã ${reg['code']}`
        // if(register['status'] === "WAIT_PAY" && ){
        // }
    }
    // receipt['refId'] = reg["_id"]
    // receipt['schema'] = reg["refSchema"]
    db_save_many("receipts", receipt)
    // db_save("receipts", receipt)
}
var pipeline = `
{
 $match: {$and:[
 {"refSchema":"ConstructionRegistration"},
 {"refId": ObjectId("${reg['_id']}")}
 ]}
}
`

var consReg = db_find_in_schema("constructionregistration", reg['_id'])

var listReceipt = db_execute("receipts", pipeline)
var isPaid = listReceipt.every((e) => (e['payment_status'] === "PAID"))
if (isPaid && register['status'] === "WAIT_PAY") {
    consReg['status'] = "WAIT_PAY"
    history["status"] = "WAIT_PAY"
    db_save_uncontrol("constructionregistration", consReg)
}
if (history != null) {
    history['constructionregistrationId'] = reg["_id"]

    db_save("constructionhistory", history)
}

return "Đăng ký thi công thành công"