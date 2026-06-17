# backend/app.py
from flask import Flask, jsonify
from flask_cors import CORS
from db_config import get_connection

app = Flask(__name__)
CORS(app)  # Allow frontend to call this API from a different port


# ── Health Check ────────────────────────────────────────────
@app.route("/api/health", methods=["GET"])
def health():
    return jsonify({
        "status": "ok",
        "message": "API is running"
    })


# ── KPIs ────────────────────────────────────────────────────
@app.route("/api/kpis", methods=["GET"])
def kpis():
    try:
        conn   = get_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM kpi_summary")
        data = cursor.fetchone()
        cursor.close()
        conn.close()
        return jsonify(data)
    except Exception as e:
        return jsonify({"error": str(e)}), 500


# ── Monthly Orders ───────────────────────────────────────────
@app.route("/api/monthly-orders", methods=["GET"])
def monthly_orders():
    try:
        conn   = get_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM monthly_order_summary")
        data = cursor.fetchall()
        cursor.close()
        conn.close()
        return jsonify(data)
    except Exception as e:
        return jsonify({"error": str(e)}), 500


# ── Category Revenue ─────────────────────────────────────────
@app.route("/api/category-revenue", methods=["GET"])
def category_revenue():
    try:
        conn   = get_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM category_revenue_summary")
        data = cursor.fetchall()
        cursor.close()
        conn.close()
        return jsonify(data)
    except Exception as e:
        return jsonify({"error": str(e)}), 500


# ── State Delivery ───────────────────────────────────────────
@app.route("/api/state-delivery", methods=["GET"])
def state_delivery():
    try:
        conn   = get_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM state_delivery_summary")
        data = cursor.fetchall()
        cursor.close()
        conn.close()
        return jsonify(data)
    except Exception as e:
        return jsonify({"error": str(e)}), 500


# ── Payment Summary ──────────────────────────────────────────
@app.route("/api/payment-summary", methods=["GET"])
def payment_summary():
    try:
        conn   = get_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM payment_summary")
        data = cursor.fetchall()
        cursor.close()
        conn.close()
        return jsonify(data)
    except Exception as e:
        return jsonify({"error": str(e)}), 500


# ── Review vs Delivery ───────────────────────────────────────
@app.route("/api/review-delivery", methods=["GET"])
def review_delivery():
    try:
        conn   = get_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM review_delivery_summary")
        data = cursor.fetchall()
        cursor.close()
        conn.close()
        return jsonify(data)
    except Exception as e:
        return jsonify({"error": str(e)}), 500


# ── Run Server ───────────────────────────────────────────────
if __name__ == "__main__":
    app.run(debug=True, port=5000)