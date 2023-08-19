module.exports = async function (context, req) {
    context.log('JavaScript HTTP trigger function processed a request.');

    const name = (req.query.name || (req.body && req.body.name));
    const responseMessage = name
        ? "Hello, " + name + ". This HTTP triggered function executed successfully."
        : "This HTTP triggered function executed successfully byyy Priyank Vaidya. Azure Azure Aindabaaaddddd!!";

    context.res = {
        // status: 200, /* Defaults to 200 */
        body: responseMessage
    };
}